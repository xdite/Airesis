#encoding: utf-8
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include GroupsHelper, NotificationHelper, StepHelper
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  after_filter :discard_flash_if_xhr

  before_filter :store_location #store the address where you come from
  before_filter :set_locale
  around_filter :user_time_zone, :if => :current_user
  before_filter :prepare_for_mobile

  before_filter :load_tutorial

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }


  protected

  def load_tutorial
    @step = get_next_step(current_user)  if current_user
  end

  def ckeditor_filebrowser_scope(options = {})
    options = {:assetable_id => current_user.id, :assetable_type => 'User'}.merge(options)
    super
  end


  def load_group
    if params[:group_id].to_s != ''
      @group = Group.find(params[:group_id])
    elsif !['', 'www'].include? request.subdomain
      @group = Group.find_by_subdomain(request.subdomain)
    end
    @group
  end

  def extract_locale_from_tld

  end

  def set_locale
    @domain_locale = request.host.split('.').last
    params[:l] = SysLocale.find_by_key(params[:l]) ? params[:l] : nil
    @locale =
        (Rails.env == :staging ?
            params[:l] || I18n.default_locale :
            params[:l] || @domain_locale || I18n.default_locale)

    @locale = 'en' if ['en', 'eu'].include? @locale
    @locale = 'en-US' if ['us'].include? @locale
	@locale = 'zh' if ['cn'].include? @locale
    @locale = 'it-IT' if ['it', 'org', 'net'].include? @locale
    I18n.locale = @locale
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def default_url_options(options={})
    #return {} if extract_locale_from_tld
    #return {} if params[:l] == I18n.default_locale
    #logger.debug "default_url_options is passed options: #{options.inspect}\n"
    (!params[:l] || (params[:l] == @domain_locale)) ? {} : {:l => I18n.locale}
  end

  #for devise. that a shit! why it doesn not use the other method?
  def self.default_url_options(options={})
    {:l => I18n.locale }
  end

  helper_method :is_admin?, :is_moderator?, :is_proprietary?, :current_url, :link_to_auth, :mobile_device?, :age, :is_group_admin?, :in_subdomain?


  def log_error(exception)
    notifier = Rails.application.config.middleware.detect { |x| x.klass == ExceptionNotifier }
    if notifier
      env = request.env
      env['exception_notifier.options'] = notifier.args.first || {}
      ExceptionNotifier::Notifier.exception_notification(env, exception).deliver
      env['exception_notifier.delivered'] = true
    end
    message = "\n#{exception.class} (#{exception.message}):\n"
    Rails.logger.error(message)
  end


  def render_error(exception)
    log_error(exception)
    render :template => "/errors/500.html.erb", :status => 500
  end

  def render_404(exception=nil)
    log_error(exception) if exception
    respond_to do |format|
      format.html { render "errors/404", :status => 404, :layout => true }
      #format.xml  { render :nothing => true, :status => '404 Not Found' }
    end
    true
  end


  def current_url(overwrite={})
    url_for params.merge(overwrite).merge(:only_path => false)
  end

  #helper method per determinare se l'utente attualmente collegato è amministratore di sistema
  def is_admin?
    user_signed_in? && current_user.admin?
  end

  #helper method per determinare se l'utente attualmente collegato è amministratore di gruppo
  def is_group_admin?(group)
    (current_user && (group.portavoce.include? current_user)) || is_admin?
  end

  #helper method per determinare se l'utente attualmente collegato è amministratore di sistema
  def is_moderator?
    user_signed_in? && current_user.moderator?
  end

  #helper method per determinare se l'utente attualmente collegato è il proprietario di un determinato oggetto
  def is_proprietary?(object)
    if (current_user && current_user.is_mine?(object))
      return true
    else
      return false
    end
  end

  def age(birthdate)
    today = Date.today
    puts 'today: ' + today.to_s
    # Difference in years, less one if you have not had a birthday this year.
    a = today.year - birthdate.year
    a = a - 1 if (
    birthdate.month > today.month or
        (birthdate.month >= today.month and birthdate.day > today.day)
    )
    a
  end


  def link_to_auth (text, link)
    return "<a>login</a>"
  end

  def title(ttl)
    @page_title = ttl
  end


  def admin_required
    is_admin? || admin_denied
  end

  def moderator_required
    is_admin? ||is_moderator? || admin_denied
  end

  def in_subdomain?
    request.subdomain.present? && request.subdomain != 'www'
  end


  #risposta nel caso sia necessario essere amministartori
  def admin_denied
    respond_to do |format|
      format.js do #se era una chiamata ajax, mostra il messaggio
        flash.now[:error] = t('error.admin_required')
        render :update do |page|
          page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
        end
      end
      format.html do #ritorna indietro oppure all'HomePage
        store_location
        flash[:error] = t('error.admin_required')
        if request.env["HTTP_REFERER"]
          redirect_to :back
        else
          redirect_to proposals_path
        end
      end
    end
  end

  #risposta generica nel caso non si abbiano i privilegi per eseguire l'operazione
  def permissions_denied(exception=nil)
    respond_to do |format|
      format.js do #se era una chiamata ajax, mostra il messaggio
        flash.now[:error] =  exception.message
        render :update do |page|
          page.replace_html "flash_messages", :partial => 'layouts/flash', :locals => {:flash => flash}
        end
      end
      format.html do #ritorna indietro oppure all'HomePage
        store_location
        flash[:error] = exception.message
        if request.env["HTTP_REFERER"]
          redirect_to :back
        else
          redirect_to proposals_path
        end
      end
    end
  end

  #salva l'url
  def store_location
    #if (params[:controller] == "proposal_comments" && params[:action] == "create")
    #  session[:user_return_to] = request.url
    #  return
    #end
    unless (request.xhr? ||
        (!params[:controller]) ||
        (params[:controller].starts_with? "devise/") ||
        (params[:controller] == "passwords") ||
        (params[:controller] == "users/omniauth_callbacks") ||
        (params[:controller] == "alerts" && params[:action] == "polling") ||
        (params[:controller] == "users" && (params[:action] == "join_accounts" || params[:action] == "confirm_credentials")) ||
        (params[:action] == 'feedback'))
      session[:proposal_id] = nil
      session[:proposal_comment] = nil
      session[:user_return_to] = request.url
    end
    # If devise model is not User, then replace :user_return_to with :{your devise model}_return_to
  end


  def post_contribute
    ProposalComment.transaction do
      @proposal_comment = @proposal.comments.build(params[:proposal_comment])
      @proposal_comment.user_id = current_user.id
      @proposal_comment.request = request
      @proposal_comment.save!
      @ranking = ProposalCommentRanking.new
      @ranking.user_id = current_user.id
      @ranking.proposal_comment_id = @proposal_comment.id
      @ranking.ranking_type_id = RankingType::POSITIVE
      @ranking.save!

      generate_nickname(current_user, @proposal)

      Resque.enqueue_in(1, NotificationProposalCommentCreate, @proposal_comment.id)
      if @proposal_comment.is_contribute?

        if @proposal_comment.paragraph
          @section = @proposal_comment.paragraph.section
          if params[:right]
            flash[:notice] = t('info.proposal.contribute_added')
          else
            flash[:notice] = t('info.proposal.contribute_added_right', {section: @section.title})
          end
        else
          flash[:notice] = t('info.proposal.contribute_added')
        end
      else
        flash[:notice] = t('info.proposal.comment_added')
      end
      #if it's lateral show a message, else show show another message

    end
  end

  def generate_nickname(user, proposal)
    nickname = ProposalNickname.find_by_user_id_and_proposal_id(user.id, proposal.id)
    unless nickname
      loop = true
      while loop do
        nickname = NicknameGeneratorHelper.give_me_a_nickname
        loop = ProposalNickname.find_by_proposal_id_and_nickname(proposal.id, nickname)
      end
      ProposalNickname.create(:user_id => user.id, :proposal_id => proposal.id, :nickname => nickname)

      @generated_nickname = @proposal.is_anonima?
    end
  end


  #redirect all'ultima pagina in cui ero
  def after_sign_in_path_for(resource)
    #se in sessione ho memorizzato un contributo, inseriscilo e mandami alla pagina della proposta
    if session[:proposal_comment] && session[:proposal_id]
      @proposal = Proposal.find(session[:proposal_id])
      params[:proposal_comment] = session[:proposal_comment]
      session[:proposal_id] = nil
      session[:proposal_comment] = nil
      post_contribute rescue nil
      proposal_path(@proposal)
    else
      env = request.env
      ret = env['omniauth.origin'] || stored_location_for(resource) || root_path
      ret
    end
  end

  #redirect alla pagina delle proposte
  def after_sign_up_path_for(resource)
    proposals_path
  end

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from Exception, :with => :render_error
  #   rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  #   rescue_from ActionController::RoutingError, :with => :render_404
  #   rescue_from ActionController::UnknownController, :with => :render_404
  #   rescue_from ::AbstractController::ActionNotFound, :with => :render_404
  # end
# 
  # rescue_from CanCan::AccessDenied do |exception|
  #   permissions_denied(exception)
  # end

  #check as rode all the alerts of the page.
  #it's a generic method but with a per-page solution
  #call it in an after_filter
  def check_page_alerts
    if current_user
      case params[:controller]
        when 'proposals'
          case params[:action]
            when 'show'
              #mark as checked all user alerts about this proposal
              @unread = current_user.user_alerts.joins({:notification => :notification_data}).where(['notification_data.name = ? and notification_data.value = ? and user_alerts.checked = ?', 'proposal_id', @proposal.id.to_s, false])
              if @unread.where(['notifications.notification_type_id = ?', NotificationType::AVAILABLE_AUTHOR]).exists?
                flash[:info] = t('info.proposal.available_authors')
              end
              @unread.check_all
              @not_count = ProposalAlert.find_by_user_id_and_proposal_id(current_user.id,@proposal.id)
              @not_count.update_attribute(:count,0) if @not_count #just to be sure. if everything is correct this would not be required but what if not?...just leave it here
            else
          end
        when 'blog_posts'
          case params[:action]
            when 'show'
              #mark as checked all user alerts about this proposal
              @unread = current_user.user_alerts.joins({:notification => :notification_data}).where(['notification_data.name = ? and notification_data.value = ? and user_alerts.checked = ?', 'blog_post_id', @blog_post.id.to_s, false])
              @unread.check_all
            else
          end
        else
      end
    end
  end

  private

  def forem_admin?(group)
    can? :update, group
  end

  helper_method :forem_admin?

  def forem_admin_or_moderator?(forum)
    can? :update, forum.group || forum.moderator?(current_user)
  end

  helper_method :forem_admin_or_moderator?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if false #mobile_device?
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

end
