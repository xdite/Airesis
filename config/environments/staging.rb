Airesis::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  config.assets.precompile += %w(endless_page.js back_enabled.png landing.css redmond/custom.css menu_left.css jquery.js ice/index.js)


  # Generate digests for assets URLs
  config.assets.digest = true

  config.assets.debug = false

  config.active_support.deprecation = :notify

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

# Log the query plan for queries taking more than this (works
# with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.4


  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
    :api_key  => Setting.mailgun.api_key,
    :api_host => Setting.mailgun.api_host
  }

  config.action_mailer.default_url_options               = {
    :host => Setting.domain.sub("http://", "")
  }

  config.action_mailer.logger = nil

  config.logger = Logger.new(Rails.root.join("log", Rails.env + ".log"), 50, 100.megabytes)

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  #indirizzo del sito
  SITE="http://airesistest.alwaysdata.net"
  #numero massimo di commenti per pagina
  COMMENTS_PER_PAGE=5
  #numero massimo di proposte per pagina
  PROPOSALS_PER_PAGE=10

  #numero di giorni senza aggiornamenti dopo i quali la proposta viene abolita
  PROP_DAY_STALLED=2

  #limita il numero di commenti
  LIMIT_COMMENTS=true
  COMMENTS_TIME_LIMIT=30.seconds

  #limita il numero di proposte
  LIMIT_PROPOSALS=true
  PROPOSALS_TIME_LIMIT=2.minutes

  #limita il numero di gruppi
  LIMIT_GROUPS=true
  GROUPS_TIME_LIMIT=24.hours

  ROTP_DRIFT = 20

  config.middleware.use ExceptionNotifier,
                        :email_prefix => "[Exception] ",
                        :sender_address => %{"Exception Notifier" <coorasse+notifier@gmail.com>},
                        :exception_recipients => %w{coorasse+exceptions@gmail.com}

end

ActionMailer::Base.default :from => "AiresisTest <info@airesis.it>"


# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  require "omniauth-facebook"
  config.omniauth :facebook, Setting.facebook_app_id , Setting.facebook_app_secret ,
                  {:scope => 'email', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}

  require "omniauth-google-oauth2"
  config.omniauth :google_oauth2, Setting.google_app_id , Setting.google_app_secret, {access_type: "offline", approval_prompt: ""}

  require "omniauth-twitter"
  config.omniauth :twitter, Setting.twitter_app_id , Setting.twitter_app_secret

  require "omniauth-meetup"
  config.omniauth :meetup, Setting.meetup_app_id, Setting.meetup_app_secret

  require "omniauth-linkedin"
  config.omniauth :linkedin, Setting.linkedin_app_id, Setting.linkedin_app_secret

end
