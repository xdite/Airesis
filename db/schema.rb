# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140226212835) do

  create_table "action_abilitations", :force => true do |t|
    t.integer  "group_action_id"
    t.integer  "partecipation_role_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "area_action_abilitations", :force => true do |t|
    t.integer  "group_action_id", :null => false
    t.integer  "area_role_id",    :null => false
    t.integer  "group_area_id",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "area_partecipations", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "group_area_id", :null => false
    t.integer  "area_role_id",  :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "area_proposals", :force => true do |t|
    t.integer  "proposal_id",   :null => false
    t.integer  "group_area_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "area_roles", :force => true do |t|
    t.integer  "group_area_id"
    t.string   "name",          :null => false
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer "user_id",                 :null => false
    t.string  "provider"
    t.string  "token"
    t.string  "uid",      :limit => 100
  end

  create_table "available_authors", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "available_authors", ["proposal_id", "user_id"], :name => "index_available_authors_on_proposal_id_and_user_id", :unique => true

  create_table "banned_emails", :force => true do |t|
    t.string   "email",      :limit => 200, :null => false
    t.datetime "created_at",                :null => false
  end

  add_index "banned_emails", ["email"], :name => "index_banned_emails_on_email", :unique => true

  create_table "blocked_alerts", :force => true do |t|
    t.integer "notification_type_id"
    t.integer "user_id"
  end

  create_table "blocked_emails", :force => true do |t|
    t.integer  "notification_type_id"
    t.integer  "user_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "blocked_proposal_alerts", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.boolean  "updates",     :default => false
    t.boolean  "contributes", :default => false
    t.boolean  "state",       :default => false
    t.boolean  "authors",     :default => false
    t.boolean  "valutations", :default => false
  end

  create_table "blog_comments", :force => true do |t|
    t.integer  "parent_blog_comment_id"
    t.integer  "blog_post_id"
    t.integer  "user_id"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "name"
    t.string   "site_url"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_post_images", :force => true do |t|
    t.integer "blog_post_id", :null => false
    t.integer "image_id",     :null => false
  end

  add_index "blog_post_images", ["blog_post_id", "image_id"], :name => "Constraint0", :unique => true

  create_table "blog_post_tags", :force => true do |t|
    t.integer "blog_post_id"
    t.integer "tag_id",       :null => false
  end

  add_index "blog_post_tags", ["blog_post_id", "tag_id"], :name => "index_blog_post_tags_on_blog_post_id_and_tag_id", :unique => true

  create_table "blog_post_versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "blog_post_versions", ["item_type", "item_id"], :name => "index_blog_post_versions_on_item_type_and_item_id"

  create_table "blog_posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title",                           :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",    :default => false, :null => false
    t.datetime "published_at"
    t.integer  "user_id"
  end

  create_table "blog_tags", :force => true do |t|
    t.integer "blog_id"
    t.integer "tag_id",  :null => false
  end

  add_index "blog_tags", ["blog_id", "tag_id"], :name => "index_blog_tags_on_blog_id_and_tag_id", :unique => true

  create_table "blogs", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
  end

  create_table "candidates", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "election_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  add_index "candidates", ["user_id", "election_id"], :name => "index_candidates_on_user_id_and_election_id", :unique => true

  create_table "circoscriziones", :force => true do |t|
    t.integer "comune_id"
    t.string  "description",   :limit => 100
    t.integer "provincia_id"
    t.integer "regione_id"
    t.integer "stato_id"
    t.integer "continente_id"
  end

  add_index "circoscriziones", ["continente_id"], :name => "index_circoscriziones_on_continente_id"
  add_index "circoscriziones", ["provincia_id"], :name => "index_circoscriziones_on_provincia_id"
  add_index "circoscriziones", ["regione_id"], :name => "index_circoscriziones_on_regione_id"
  add_index "circoscriziones", ["stato_id"], :name => "index_circoscriziones_on_stato_id"

  create_table "circoscrizioni_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "circoscrizione_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comunali_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "comune_id"
  end

  create_table "comunes", :force => true do |t|
    t.string  "description",   :limit => 100, :null => false
    t.integer "provincia_id",                 :null => false
    t.integer "regione_id",                   :null => false
    t.integer "population"
    t.string  "codistat",      :limit => 4
    t.string  "cap",           :limit => 5
    t.integer "stato_id"
    t.integer "continente_id"
  end

  add_index "comunes", ["continente_id"], :name => "index_comunes_on_continente_id"
  add_index "comunes", ["regione_id"], :name => "index_comunes_on_regione_id"
  add_index "comunes", ["stato_id"], :name => "index_comunes_on_stato_id"

  create_table "configurations", :force => true do |t|
    t.string "name",  :limit => 100, :null => false
    t.string "value",                :null => false
  end

  create_table "continente_translations", :force => true do |t|
    t.integer  "continente_id"
    t.string   "locale"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "continente_translations", ["continente_id"], :name => "index_continente_translations_on_continente_id"
  add_index "continente_translations", ["locale"], :name => "index_continente_translations_on_locale"

  create_table "continentes", :force => true do |t|
    t.string "description", :null => false
  end

  create_table "election_votes", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "election_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "election_votes", ["user_id", "election_id"], :name => "index_election_votes_on_user_id_and_election_id", :unique => true

  create_table "elections", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "description",                            :null => false
    t.integer  "event_id",                               :null => false
    t.datetime "groups_end_time",                        :null => false
    t.datetime "candidates_end_time",                    :null => false
    t.string   "status",              :default => "1",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "score_calculated",    :default => false
  end

  create_table "event_comment_likes", :force => true do |t|
    t.integer  "event_comment_id", :null => false
    t.integer  "user_id",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "event_comment_likes", ["event_comment_id", "user_id"], :name => "index_event_comment_likes_on_event_comment_id_and_user_id", :unique => true
  add_index "event_comment_likes", ["event_comment_id"], :name => "index_event_comment_likes_on_event_comment_id"
  add_index "event_comment_likes", ["user_id"], :name => "index_event_comment_likes_on_user_id"

  create_table "event_comments", :force => true do |t|
    t.integer  "parent_event_comment_id"
    t.integer  "event_id",                                :null => false
    t.integer  "user_id",                                 :null => false
    t.integer  "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "body",                    :limit => 2500, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "event_comments", ["event_id"], :name => "index_event_comments_on_event_id"
  add_index "event_comments", ["parent_event_comment_id"], :name => "index_event_comments_on_parent_event_comment_id"
  add_index "event_comments", ["user_id"], :name => "index_event_comments_on_user_id"

  create_table "event_series", :force => true do |t|
    t.integer  "frequency",  :default => 1
    t.string   "period",     :default => "months"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", :force => true do |t|
    t.string "name"
    t.string "color", :limit => 10
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "event_series_id"
    t.integer  "event_type_id",                      :null => false
    t.boolean  "private",         :default => false, :null => false
    t.integer  "user_id"
  end

  add_index "events", ["event_series_id"], :name => "index_events_on_event_series_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "frm_categories", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "slug"
    t.integer  "group_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "visible_outside", :default => true
  end

  add_index "frm_categories", ["group_id", "slug"], :name => "index_frm_categories_on_group_id_and_slug", :unique => true
  add_index "frm_categories", ["slug"], :name => "index_frm_categories_on_slug"

  create_table "frm_category_tags", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "frm_category_id"
    t.integer  "tag_id"
  end

  create_table "frm_forum_tags", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "frm_forum_id"
    t.integer  "tag_id"
  end

  create_table "frm_forums", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "group_id"
    t.integer "views_count",     :default => 0
    t.string  "slug"
    t.boolean "visible_outside", :default => true
  end

  add_index "frm_forums", ["group_id", "slug"], :name => "index_frm_forums_on_group_id_and_slug", :unique => true
  add_index "frm_forums", ["slug"], :name => "index_frm_forums_on_slug"

  create_table "frm_groups", :force => true do |t|
    t.string  "name"
    t.integer "group_id"
  end

  add_index "frm_groups", ["name"], :name => "index_frm_groups_on_name"

  create_table "frm_memberships", :force => true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "frm_memberships", ["group_id"], :name => "index_frm_memberships_on_group_id"

  create_table "frm_moderator_groups", :force => true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "frm_moderator_groups", ["forum_id"], :name => "index_frm_moderator_groups_on_forum_id"

  create_table "frm_posts", :force => true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.integer  "reply_to_id"
    t.string   "state",       :default => "pending_review"
    t.boolean  "notified",    :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "token"
  end

  add_index "frm_posts", ["reply_to_id"], :name => "index_frm_posts_on_reply_to_id"
  add_index "frm_posts", ["state"], :name => "index_frm_posts_on_state"
  add_index "frm_posts", ["token"], :name => "index_frm_posts_on_token", :unique => true
  add_index "frm_posts", ["topic_id"], :name => "index_frm_posts_on_topic_id"
  add_index "frm_posts", ["user_id"], :name => "index_frm_posts_on_user_id"

  create_table "frm_subscriptions", :force => true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "frm_topic_proposals", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "topic_id"
    t.integer  "proposal_id"
    t.integer  "user_id"
  end

  create_table "frm_topic_tags", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "frm_topic_id"
    t.integer  "tag_id"
  end

  create_table "frm_topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.boolean  "locked",       :default => false,            :null => false
    t.boolean  "pinned",       :default => false,            :null => false
    t.boolean  "hidden",       :default => false
    t.string   "state",        :default => "pending_review"
    t.datetime "last_post_at"
    t.integer  "views_count",  :default => 0
    t.string   "slug"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "token"
  end

  add_index "frm_topics", ["forum_id", "slug"], :name => "index_frm_topics_on_forum_id_and_slug", :unique => true
  add_index "frm_topics", ["forum_id"], :name => "index_frm_topics_on_forum_id"
  add_index "frm_topics", ["slug"], :name => "index_frm_topics_on_slug"
  add_index "frm_topics", ["state"], :name => "index_frm_topics_on_state"
  add_index "frm_topics", ["token"], :name => "index_frm_topics_on_token", :unique => true
  add_index "frm_topics", ["user_id"], :name => "index_frm_topics_on_user_id"

  create_table "frm_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.integer  "count",             :default => 0
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "frm_views", ["updated_at"], :name => "index_frm_views_on_updated_at"
  add_index "frm_views", ["user_id"], :name => "index_frm_views_on_user_id"

  create_table "generic_borders", :force => true do |t|
    t.string  "description", :null => false
    t.string  "name",        :null => false
    t.integer "seq"
  end

  create_table "geometry_columns", :id => false, :force => true do |t|
    t.string  "f_table_catalog",   :limit => 256, :null => false
    t.string  "f_table_schema",    :limit => 256, :null => false
    t.string  "f_table_name",      :limit => 256, :null => false
    t.string  "f_geometry_column", :limit => 256, :null => false
    t.integer "coord_dimension",                  :null => false
    t.integer "srid",                             :null => false
    t.string  "type",              :limit => 30,  :null => false
  end

  create_table "group_actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seq"
  end

  create_table "group_areas", :force => true do |t|
    t.integer  "group_id",                           :null => false
    t.string   "name",                               :null => false
    t.string   "description",        :limit => 2000
    t.integer  "area_role_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "group_elections", :force => true do |t|
    t.integer  "group_id",    :null => false
    t.integer  "election_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_elections", ["group_id", "election_id"], :name => "index_group_elections_on_group_id_and_election_id", :unique => true

  create_table "group_follows", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "group_id", :null => false
  end

  create_table "group_invitation_emails", :force => true do |t|
    t.string   "email",      :limit => 200,                  :null => false
    t.integer  "group_id",                                   :null => false
    t.string   "accepted",   :limit => 1,   :default => "W", :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "group_invitation_emails", ["email", "group_id"], :name => "index_group_invitation_emails_on_email_and_group_id", :unique => true

  create_table "group_invitations", :force => true do |t|
    t.string   "token",                     :limit => 32,                      :null => false
    t.datetime "created_at",                                                   :null => false
    t.integer  "inviter_id",                                                   :null => false
    t.integer  "invited_id"
    t.boolean  "consumed",                                  :default => false, :null => false
    t.integer  "group_invitation_email_id",                                    :null => false
    t.string   "testo",                     :limit => 4000
  end

  add_index "group_invitations", ["group_invitation_email_id"], :name => "index_group_invitations_on_group_invitation_email_id", :unique => true

  create_table "group_partecipation_request_statuses", :force => true do |t|
    t.string "description", :limit => 200, :null => false
  end

  create_table "group_partecipation_requests", :force => true do |t|
    t.integer  "user_id",                                              :null => false
    t.integer  "group_id",                                             :null => false
    t.integer  "group_partecipation_request_status_id", :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_partecipation_requests", ["user_id", "group_id"], :name => "unique", :unique => true

  create_table "group_partecipations", :force => true do |t|
    t.integer  "user_id",                              :null => false
    t.integer  "group_id",                             :null => false
    t.integer  "partecipation_role_id", :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "acceptor_id"
  end

  add_index "group_partecipations", ["user_id", "group_id"], :name => "only_once_per_group", :unique => true

  create_table "group_proposals", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "group_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_proposals", ["proposal_id", "group_id"], :name => "index_group_proposals_on_proposal_id_and_group_id", :unique => true

  create_table "group_quorums", :force => true do |t|
    t.integer "quorum_id", :null => false
    t.integer "group_id"
  end

  add_index "group_quorums", ["quorum_id", "group_id"], :name => "index_group_quorums_on_quorum_id_and_group_id", :unique => true
  add_index "group_quorums", ["quorum_id"], :name => "index_group_quorums_on_quorum_id", :unique => true

  create_table "group_statistics", :force => true do |t|
    t.integer  "group_id",         :null => false
    t.float    "good_score"
    t.float    "vote_good_score"
    t.float    "valutations"
    t.float    "vote_valutations"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "group_tags", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
    t.integer  "tag_id"
  end

  create_table "group_versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "group_versions", ["item_type", "item_id"], :name => "index_group_versions_on_item_type_and_item_id"

  create_table "groups", :force => true do |t|
    t.string   "name",                           :limit => 200
    t.string   "description",                    :limit => 2500
    t.string   "accept_requests",                                 :default => "p",      :null => false
    t.integer  "interest_border_id"
    t.string   "facebook_page_url"
    t.integer  "image_id"
    t.string   "title_bar"
    t.string   "image_url"
    t.integer  "partecipation_role_id",                           :default => 1,        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "change_advanced_options",                         :default => true,     :null => false
    t.boolean  "default_anonima",                                 :default => true,     :null => false
    t.boolean  "default_visible_outside",                         :default => false,    :null => false
    t.boolean  "default_secret_vote",                             :default => true,     :null => false
    t.integer  "max_storage_size",                                :default => 51200,    :null => false
    t.integer  "actual_storage_size",                             :default => 0,        :null => false
    t.boolean  "enable_areas",                                    :default => false,    :null => false
    t.integer  "group_partecipations_count",                      :default => 1,        :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "admin_title",                    :limit => 200
    t.boolean  "private",                                         :default => false
    t.string   "rule_book",                      :limit => 40000
    t.string   "subdomain",                      :limit => 100
    t.boolean  "certified",                                       :default => false,    :null => false
    t.string   "status",                                          :default => "active", :null => false
    t.datetime "status_changed_at"
    t.string   "slug"
    t.boolean  "disable_partecipation_requests",                  :default => false
    t.boolean  "disable_forums",                                  :default => false
    t.boolean  "disable_documents",                               :default => false
  end

  add_index "groups", ["slug"], :name => "index_groups_on_slug"
  add_index "groups", ["subdomain"], :name => "index_groups_on_subdomain", :unique => true

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integrated_contributes", :force => true do |t|
    t.integer "proposal_revision_id", :null => false
    t.integer "proposal_comment_id",  :null => false
  end

  add_index "integrated_contributes", ["proposal_revision_id", "proposal_comment_id"], :name => "unique_contributes", :unique => true

  create_table "interest_borders", :force => true do |t|
    t.integer "territory_id",   :null => false
    t.string  "territory_type", :null => false
  end

  create_table "meeting_organizations", :force => true do |t|
    t.integer "group_id"
    t.integer "event_id"
  end

  create_table "meeting_partecipations", :force => true do |t|
    t.integer "user_id"
    t.integer "meeting_id"
    t.string  "comment"
    t.integer "guests",                  :default => 0, :null => false
    t.string  "response",   :limit => 1
  end

  create_table "meetings", :force => true do |t|
    t.integer "place_id"
    t.integer "event_id"
  end

  create_table "notification_categories", :force => true do |t|
    t.integer "seq"
    t.string  "short", :limit => 8
  end

  create_table "notification_data", :force => true do |t|
    t.integer "notification_id",                 :null => false
    t.string  "name",            :limit => 100,  :null => false
    t.string  "value",           :limit => 4000
  end

  add_index "notification_data", ["notification_id", "name"], :name => "index_notification_data_on_notification_id_and_name", :unique => true

  create_table "notification_types", :force => true do |t|
    t.integer "notification_category_id", :null => false
    t.string  "name"
  end

  create_table "notifications", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notification_type_id",                 :null => false
    t.string   "message",              :limit => 1000
    t.string   "url",                  :limit => 400
  end

  create_table "old_proposal_presentations", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "proposal_life_id"
    t.integer  "user_id"
  end

  create_table "paragraph_histories", :force => true do |t|
    t.integer "section_history_id",                  :null => false
    t.string  "content",            :limit => 40000
    t.integer "seq",                                 :null => false
    t.integer "proposal_id",                         :null => false
  end

  add_index "paragraph_histories", ["proposal_id"], :name => "index_paragraph_histories_on_proposal_id"

  create_table "paragraphs", :force => true do |t|
    t.integer "section_id",                  :null => false
    t.string  "content",    :limit => 40000
    t.integer "seq",                         :null => false
  end

  create_table "partecipation_roles", :force => true do |t|
    t.integer "parent_partecipation_role_id"
    t.integer "group_id"
    t.string  "name",                         :limit => 200
    t.string  "description",                  :limit => 2000
  end

  create_table "periods", :force => true do |t|
    t.datetime "from", :null => false
    t.datetime "to",   :null => false
  end

  add_index "periods", ["from", "to"], :name => "from_to_unique", :unique => true

  create_table "places", :force => true do |t|
    t.integer "comune_id"
    t.string  "frazione",           :limit => 200
    t.string  "address",            :limit => 200
    t.string  "civic_number",       :limit => 10
    t.string  "cap",                :limit => 5
    t.float   "latitude_original"
    t.float   "longitude_original"
    t.float   "latitude_center"
    t.float   "longitude_center"
    t.integer "zoom"
  end

  create_table "post_publishings", :force => true do |t|
    t.integer "blog_post_id"
    t.integer "group_id"
  end

  create_table "proposal_alerts", :force => true do |t|
    t.integer "proposal_id",                :null => false
    t.integer "user_id",                    :null => false
    t.integer "count",       :default => 0, :null => false
  end

  create_table "proposal_borders", :force => true do |t|
    t.integer "proposal_id",        :null => false
    t.integer "interest_border_id", :null => false
    t.integer "created_at"
  end

  add_index "proposal_borders", ["proposal_id"], :name => "_idx_proposal_borderds_proposal_id"

  create_table "proposal_categories", :force => true do |t|
    t.integer "parent_proposal_category_id"
    t.string  "name"
    t.integer "seq"
  end

  create_table "proposal_comment_rankings", :force => true do |t|
    t.integer  "proposal_comment_id", :null => false
    t.integer  "user_id",             :null => false
    t.integer  "ranking_type_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_comment_rankings", ["proposal_comment_id", "user_id"], :name => "user_comment", :unique => true

  create_table "proposal_comment_report_types", :force => true do |t|
    t.string  "description",                :null => false
    t.integer "severity",    :default => 0, :null => false
    t.integer "seq"
  end

  create_table "proposal_comment_reports", :force => true do |t|
    t.integer "proposal_comment_id",             :null => false
    t.integer "user_id",                         :null => false
    t.integer "proposal_comment_report_type_id", :null => false
  end

  add_index "proposal_comment_reports", ["proposal_comment_id", "user_id"], :name => "reports_index", :unique => true

  create_table "proposal_comment_versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "proposal_comment_versions", ["item_type", "item_id"], :name => "index_proposal_comment_versions_on_item_type_and_item_id"

  create_table "proposal_comments", :force => true do |t|
    t.integer  "parent_proposal_comment_id"
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.boolean  "deleted",                                    :default => false, :null => false
    t.integer  "deleted_user_id"
    t.datetime "deleted_at"
    t.string   "content",                    :limit => 2500
    t.integer  "rank",                                       :default => 0,     :null => false
    t.integer  "valutations",                                :default => 0,     :null => false
    t.integer  "paragraph_id"
    t.decimal  "j_value",                                    :default => 0.0,   :null => false
    t.boolean  "integrated",                                 :default => false, :null => false
    t.integer  "grave_reports_count",                        :default => 0,     :null => false
    t.integer  "soft_reports_count",                         :default => 0,     :null => false
    t.boolean  "noise",                                      :default => false
  end

  create_table "proposal_histories", :force => true do |t|
    t.integer  "proposal_id",                  :null => false
    t.integer  "user_id",                      :null => false
    t.text   "content",     :null => false
    t.text   "problem"
    t.integer  "valutations",                  :null => false
    t.integer  "rank",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_lives", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "proposal_id"
    t.integer  "quorum_id"
    t.integer  "valutations"
    t.integer  "rank"
    t.integer  "seq"
  end

  create_table "proposal_nicknames", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "user_id",     :null => false
    t.string   "nickname",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_nicknames", ["nickname"], :name => "index_proposal_nicknames_on_nickname"
  add_index "proposal_nicknames", ["proposal_id", "nickname"], :name => "index_proposal_nicknames_on_proposal_id_and_nickname", :unique => true
  add_index "proposal_nicknames", ["proposal_id", "user_id"], :name => "index_proposal_nicknames_on_proposal_id_and_user_id", :unique => true

  create_table "proposal_presentations", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_presentations", ["proposal_id"], :name => "_idx_proposal_presentations_proposal_id"
  add_index "proposal_presentations", ["user_id", "proposal_id"], :name => "index_proposal_presentations_on_user_id_and_proposal_id", :unique => true
  add_index "proposal_presentations", ["user_id"], :name => "_idx_proposal_presentations_user_id"

  create_table "proposal_rankings", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.integer  "ranking_type_id"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "proposal_rankings", ["proposal_id", "user_id"], :name => "proposal_user", :unique => true

  create_table "proposal_revisions", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.integer  "valutations"
    t.integer  "rank"
    t.integer  "seq",         :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "proposal_revisions", ["proposal_id"], :name => "index_proposal_revisions_on_proposal_id"

  create_table "proposal_schulze_votes", :force => true do |t|
    t.integer  "proposal_id",                :null => false
    t.string   "preferences",                :null => false
    t.integer  "count",       :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "proposal_sections", :force => true do |t|
    t.integer "proposal_id", :null => false
    t.integer "section_id",  :null => false
  end

  add_index "proposal_sections", ["section_id"], :name => "index_proposal_sections_on_section_id", :unique => true

  create_table "proposal_states", :force => true do |t|
    t.string "description", :limit => 200
  end

  create_table "proposal_supports", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "group_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_tags", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "tag_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposal_tags", ["proposal_id", "tag_id"], :name => "index_proposal_tags_on_proposal_id_and_tag_id", :unique => true

  create_table "proposal_types", :force => true do |t|
    t.string  "name",   :limit => 10,                    :null => false
    t.integer "seq",                  :default => 0
    t.boolean "active",               :default => false
    t.string  "color",  :limit => 10
  end

  create_table "proposal_votation_types", :force => true do |t|
    t.string "short_name",  :limit => 10, :null => false
    t.string "description",               :null => false
  end

  create_table "proposal_votes", :force => true do |t|
    t.integer  "proposal_id", :limit => 8
    t.integer  "positive"
    t.integer  "negative"
    t.integer  "neutral"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_watches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.integer  "proposal_state_id"
    t.integer  "proposal_category_id",                       :default => 5,     :null => false
    t.string   "title",                     :limit => 200,                      :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "valutations",                                :default => 0
    t.integer  "vote_period_id"
    t.integer  "proposal_comments_count",                    :default => 0
    t.integer  "rank",                                       :default => 0,     :null => false
    t.text   "problem"
    t.string   "subtitle",                                   :default => "",    :null => false
    t.text   "problems", :default => "",    :null => false
    t.text   "objectives", :default => "",    :null => false
    t.boolean  "show_comment_authors",                       :default => true,  :null => false
    t.boolean  "private",                                    :default => false, :null => false
    t.integer  "quorum_id"
    t.boolean  "anonima",                                    :default => true,  :null => false
    t.boolean  "visible_outside",                            :default => false, :null => false
    t.boolean  "secret_vote",                                :default => true,  :null => false
    t.integer  "proposal_type_id",                           :default => 1,     :null => false
    t.integer  "proposal_votation_type_id",                  :default => 1,     :null => false
    t.string   "url",                                                           :null => false
    t.boolean  "vote_defined",                               :default => false
    t.datetime "vote_starts_at"
    t.datetime "vote_ends_at"
    t.integer  "vote_event_id"
  end

  add_index "proposals", ["proposal_category_id"], :name => "_idx_proposals_proposal_category_id"
  add_index "proposals", ["proposal_state_id"], :name => "_idx_proposals_proposal_state_id"
  add_index "proposals", ["quorum_id"], :name => "index_proposals_on_quorum_id", :unique => true
  add_index "proposals", ["updated_at"], :name => "index_proposals_on_updated_at"
  add_index "proposals", ["vote_period_id"], :name => "_idx_proposals_vote_period_id"

  create_table "provinciali_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "provincia_id"
  end

  create_table "provincias", :force => true do |t|
    t.string  "description",   :limit => 100
    t.integer "regione_id",                   :null => false
    t.string  "sigla",         :limit => 5
    t.integer "stato_id"
    t.integer "population"
    t.integer "continente_id"
  end

  add_index "provincias", ["continente_id"], :name => "index_provincias_on_continente_id"
  add_index "provincias", ["stato_id"], :name => "index_provincias_on_stato_id"

  create_table "quorums", :force => true do |t|
    t.string   "name",              :limit => 100,                     :null => false
    t.string   "description",       :limit => 4000
    t.integer  "percentage"
    t.integer  "valutations"
    t.integer  "minutes"
    t.string   "condition",         :limit => 5
    t.integer  "bad_score",                                            :null => false
    t.integer  "good_score",                                           :null => false
    t.boolean  "active",                            :default => true,  :null => false
    t.boolean  "public",                            :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "ends_at"
    t.integer  "seq"
    t.integer  "quorum_id"
    t.integer  "vote_minutes"
    t.integer  "vote_percentage"
    t.integer  "vote_valutations"
    t.integer  "vote_good_score"
    t.datetime "vote_start_at"
    t.datetime "vote_ends_at"
    t.string   "t_percentage",      :limit => 1
    t.string   "t_minutes",         :limit => 1
    t.string   "t_good_score",      :limit => 1
    t.string   "t_vote_percentage", :limit => 1
    t.string   "t_vote_minutes",    :limit => 1
    t.string   "t_vote_good_score", :limit => 1
    t.string   "type"
    t.boolean  "removed",                           :default => false
    t.integer  "old_bad_score"
    t.string   "old_condition",     :limit => 5
    t.boolean  "assigned",                          :default => false
  end

  create_table "ranking_types", :force => true do |t|
    t.string "description", :limit => 200, :null => false
  end

  create_table "received_emails", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.string   "from"
    t.string   "to"
    t.string   "token"
    t.boolean  "read",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "regionali_groups", :id => false, :force => true do |t|
    t.integer "id",                                                  :null => false
    t.string  "name",               :limit => 200
    t.string  "description",        :limit => 2000
    t.string  "accept_requests",    :limit => 1,    :default => "v", :null => false
    t.integer "interest_border_id"
    t.integer "regione_id"
  end

  create_table "regiones", :force => true do |t|
    t.string  "description",   :limit => 100
    t.integer "stato_id",                     :null => false
    t.integer "continente_id"
  end

  add_index "regiones", ["continente_id"], :name => "index_regiones_on_continente_id"

  create_table "request_vote_types", :force => true do |t|
    t.string "description", :limit => 10, :null => false
  end

  create_table "request_votes", :force => true do |t|
    t.integer "group_partecipation_request_id",                :null => false
    t.integer "user_id",                                       :null => false
    t.integer "request_vote_type_id",                          :null => false
    t.string  "comment",                        :limit => 200
  end

  create_table "revision_section_histories", :force => true do |t|
    t.integer "proposal_revision_id", :null => false
    t.integer "section_history_id",   :null => false
  end

  add_index "revision_section_histories", ["proposal_revision_id"], :name => "index_revision_section_histories_on_proposal_revision_id"
  add_index "revision_section_histories", ["section_history_id"], :name => "index_revision_section_histories_on_section_history_id"

  create_table "schulze_votes", :force => true do |t|
    t.integer  "election_id",                :null => false
    t.string   "preferences",                :null => false
    t.integer  "count",       :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schulze_votes", ["election_id", "preferences"], :name => "index_schulze_votes_on_election_id_and_preferences", :unique => true

  create_table "search_partecipants", :force => true do |t|
    t.integer  "role_id"
    t.integer  "status_id"
    t.string   "keywords"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "search_proposals", :force => true do |t|
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "proposal_category_id"
    t.integer  "group_area_id"
    t.integer  "proposal_type_id"
    t.integer  "proposal_state_id"
    t.integer  "tag_id"
    t.integer  "interest_border_id"
    t.datetime "created_at_from"
    t.datetime "created_at_to"
  end

  create_table "section_histories", :force => true do |t|
    t.integer "section_id"
    t.string  "title",      :limit => 100, :null => false
    t.integer "seq",                       :null => false
    t.boolean "added"
    t.boolean "removed"
  end

  create_table "sections", :force => true do |t|
    t.string  "title",    :limit => 100,   :null => false
    t.integer "seq",                       :null => false
    t.text  "question"
  end

  create_table "sent_feedbacks", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "message"
    t.string   "email"
    t.text     "stack"
  end

  create_table "simple_votes", :force => true do |t|
    t.integer  "candidate_id",                :null => false
    t.integer  "count",        :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_votes", ["candidate_id"], :name => "index_simple_votes_on_candidate_id", :unique => true

  create_table "solution_histories", :force => true do |t|
    t.integer "proposal_revision_id", :null => false
    t.integer "seq",                  :null => false
    t.string  "title"
    t.boolean "added"
    t.boolean "removed"
  end

  add_index "solution_histories", ["proposal_revision_id"], :name => "index_solution_histories_on_proposal_revision_id"

  create_table "solution_section_histories", :force => true do |t|
    t.integer "solution_history_id", :null => false
    t.integer "section_history_id",  :null => false
  end

  add_index "solution_section_histories", ["section_history_id"], :name => "index_solution_section_histories_on_section_history_id"
  add_index "solution_section_histories", ["solution_history_id"], :name => "index_solution_section_histories_on_solution_history_id"

  create_table "solution_sections", :force => true do |t|
    t.integer "solution_id", :null => false
    t.integer "section_id",  :null => false
  end

  add_index "solution_sections", ["section_id"], :name => "index_solution_sections_on_section_id", :unique => true

  create_table "solutions", :force => true do |t|
    t.integer "proposal_id",   :null => false
    t.integer "seq",           :null => false
    t.integer "schulze_score"
    t.string  "title"
  end

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

  create_table "stat_num_proposals", :force => true do |t|
    t.date    "date"
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.integer "value"
  end

  create_table "stato_translations", :force => true do |t|
    t.integer  "stato_id"
    t.string   "locale"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "stato_translations", ["locale"], :name => "index_stato_translations_on_locale"
  add_index "stato_translations", ["stato_id"], :name => "index_stato_translations_on_stato_id"

  create_table "statos", :force => true do |t|
    t.string  "description",                :null => false
    t.integer "continente_id",              :null => false
    t.string  "sigla",                      :null => false
    t.string  "sigla_ext",     :limit => 3
  end

  create_table "steps", :force => true do |t|
    t.integer  "tutorial_id",                     :null => false
    t.integer  "index",       :default => 0,      :null => false
    t.string   "title"
    t.text     "content"
    t.boolean  "required",    :default => false
    t.text     "fragment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "format",      :default => "html"
  end

  create_table "supporters", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.integer  "group_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["candidate_id", "group_id"], :name => "index_supporters_on_candidate_id_and_group_id", :unique => true

  create_table "sys_currencies", :force => true do |t|
    t.string   "description", :limit => 10, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sys_document_types", :force => true do |t|
    t.string "description"
  end

  create_table "sys_features", :force => true do |t|
    t.string   "title"
    t.string   "description",        :limit => 40000
    t.float    "amount_required"
    t.float    "amount_received"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "sys_locales", :force => true do |t|
    t.string  "key"
    t.string  "host"
    t.string  "lang"
    t.string  "territory_type"
    t.integer "territory_id"
  end

  create_table "sys_movement_types", :force => true do |t|
    t.string   "description", :limit => 20, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sys_movements", :force => true do |t|
    t.integer  "sys_movement_type_id",                  :null => false
    t.integer  "sys_currency_id",                       :null => false
    t.datetime "made_on",                               :null => false
    t.integer  "user_id",                               :null => false
    t.float    "amount",                                :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "description",          :limit => 10000
  end

  create_table "sys_payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "sys_feature_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.decimal  "payment_fee"
    t.decimal  "payment_gross"
    t.string   "first_name",     :limit => 4000
    t.string   "last_name",      :limit => 4000
  end

  add_index "sys_payment_notifications", ["transaction_id"], :name => "index_sys_payment_notifications_on_transaction_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "text",                                :null => false
    t.integer  "proposals_count",      :default => 0, :null => false
    t.integer  "blog_posts_count",     :default => 0, :null => false
    t.integer  "blogs_count",          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "groups_count",         :default => 0, :null => false
    t.integer  "frm_categories_count", :default => 0, :null => false
    t.integer  "frm_forums_count",     :default => 0, :null => false
    t.integer  "frm_topics_count",     :default => 0, :null => false
  end

  add_index "tags", ["text"], :name => "index_tags_on_text", :unique => true

  create_table "tutorial_assignees", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "tutorial_id",                    :null => false
    t.boolean  "completed",   :default => false, :null => false
    t.integer  "index",       :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorial_progresses", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "step_id",                     :null => false
    t.string   "status",     :default => "N", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorials", :force => true do |t|
    t.string   "action"
    t.string   "controller", :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_alerts", :force => true do |t|
    t.integer  "notification_id", :null => false
    t.integer  "user_id"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "checked_at"
  end

  add_index "user_alerts", ["checked"], :name => "index_user_alerts_on_checked"
  add_index "user_alerts", ["user_id"], :name => "index_user_alerts_on_user_id"

  create_table "user_borders", :force => true do |t|
    t.integer "user_id",            :null => false
    t.integer "interest_border_id", :null => false
    t.integer "created_at"
  end

  add_index "user_borders", ["user_id"], :name => "_idx_user_borders_user_id"

  create_table "user_follows", :force => true do |t|
    t.integer  "follower_id", :null => false
    t.integer  "followed_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_follows", ["follower_id", "followed_id"], :name => "user_follows_unique", :unique => true

  create_table "user_likes", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id",       :null => false
    t.integer  "likeable_id",   :null => false
    t.string   "likeable_type", :null => false
  end

  create_table "user_sensitives", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.string   "name",                  :null => false
    t.string   "surname",               :null => false
    t.datetime "birth_date"
    t.integer  "birth_place_id"
    t.integer  "residence_place_id"
    t.integer  "home_place_id"
    t.string   "tax_code",              :null => false
    t.string   "document_id"
    t.integer  "sys_document_type_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "channel"
  end

  add_index "user_sensitives", ["tax_code"], :name => "index_user_sensitives_on_tax_code", :unique => true
  add_index "user_sensitives", ["user_id"], :name => "index_user_sensitives_on_user_id", :unique => true

  create_table "user_tracings", :force => true do |t|
    t.integer  "user_id"
    t.datetime "sign_in_at"
    t.datetime "sign_out_at"
    t.string   "ip"
    t.text     "user_agent"
  end

  add_index "user_tracings", ["user_id"], :name => "index_user_tracings_on_user_id"

  create_table "user_types", :force => true do |t|
    t.string "description", :limit => 200
    t.text   "short_name"
  end



  create_table "user_votes", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote_type_id"
    t.string   "vote_schulze"
    t.string   "vote_schulze_desc", :limit => 2000
  end

  add_index "user_votes", ["proposal_id", "user_id"], :name => "onlyvoteuser", :unique => true

  create_table "users", :force => true do |t|
    t.integer  "user_type_id",                              :default => 3,      :null => false
    t.integer  "residenza_id"
    t.integer  "nascita_id"
    t.string   "name",                      :limit => 100
    t.string   "surname",                   :limit => 100
    t.string   "email",                     :limit => 100
    t.string   "sex",                       :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                     :limit => 40
    t.string   "password_salt",             :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "deleted_at"
    t.text     "state"
    t.string   "reset_password_token"
    t.string   "encrypted_password",        :limit => 128,                      :null => false
    t.boolean  "activist",                                  :default => false,  :null => false
    t.boolean  "elected",                                   :default => false,  :null => false
    t.string   "blog_image_url",            :limit => 1000
    t.integer  "image_id"
    t.integer  "rank"
    t.integer  "fb_user_id"
    t.string   "email_hash"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count",                             :default => 0
    t.string   "account_type"
    t.datetime "remember_created_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "banned",                                    :default => false,  :null => false
    t.boolean  "receive_newsletter",                        :default => false,  :null => false
    t.datetime "reset_password_sent_at"
    t.string   "facebook_page_url"
    t.string   "linkedin_page_url"
    t.boolean  "blocked",                                   :default => false
    t.string   "unconfirmed_email",         :limit => 100
    t.string   "google_page_url"
    t.boolean  "show_tooltips",                             :default => true
    t.boolean  "show_urls",                                 :default => true
    t.boolean  "receive_messages",                          :default => true,   :null => false
    t.string   "authentication_token"
    t.string   "rotp_secret",               :limit => 16
    t.boolean  "rotp_enabled",                              :default => false
    t.string   "blocked_name"
    t.string   "blocked_surname"
    t.integer  "sys_locale_id",                             :default => 1,      :null => false
    t.integer  "original_sys_locale_id",                    :default => 1,      :null => false
    t.string   "time_zone",                                 :default => "Rome"
  end

  add_index "users", ["email"], :name => "uniqueemail", :unique => true
  add_index "users", ["login"], :name => "uniquelogin", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "vote_types", :force => true do |t|
    t.string "short"
  end

  add_foreign_key "action_abilitations", "group_actions", name: "action_abilitations_group_action_id_fk"
  add_foreign_key "action_abilitations", "groups", name: "action_abilitations_group_id_fk"
  add_foreign_key "action_abilitations", "partecipation_roles", name: "action_abilitations_partecipation_role_id_fk"

  add_foreign_key "area_action_abilitations", "area_roles", name: "area_action_abilitations_area_role_id_fk"
  add_foreign_key "area_action_abilitations", "group_actions", name: "area_action_abilitations_group_action_id_fk"
  add_foreign_key "area_action_abilitations", "group_areas", name: "area_action_abilitations_group_area_id_fk"

  add_foreign_key "area_partecipations", "area_roles", name: "area_partecipations_area_role_id_fk"
  add_foreign_key "area_partecipations", "group_areas", name: "area_partecipations_group_area_id_fk"
  add_foreign_key "area_partecipations", "users", name: "area_partecipations_user_id_fk"

  add_foreign_key "area_proposals", "group_areas", name: "area_proposals_group_area_id_fk"
  add_foreign_key "area_proposals", "proposals", name: "area_proposals_proposal_id_fk"

  add_foreign_key "area_roles", "group_areas", name: "area_roles_group_area_id_fk"

  add_foreign_key "authentications", "users", name: "authentications_user_id_fk"

  add_foreign_key "available_authors", "proposals", name: "available_authors_proposal_id_fk"
  add_foreign_key "available_authors", "users", name: "available_authors_user_id_fk"

  add_foreign_key "blocked_alerts", "notification_types", name: "blocked_alerts_notification_type_id_fk"
  add_foreign_key "blocked_alerts", "users", name: "blocked_alerts_user_id_fk"

  add_foreign_key "blocked_emails", "notification_types", name: "blocked_emails_notification_type_id_fk"
  add_foreign_key "blocked_emails", "users", name: "blocked_emails_user_id_fk"

  add_foreign_key "blocked_proposal_alerts", "proposals", name: "blocked_proposal_alerts_proposal_id_fk"
  add_foreign_key "blocked_proposal_alerts", "users", name: "blocked_proposal_alerts_user_id_fk"

  add_foreign_key "blog_comments", "blog_comments", name: "blog_comments_parent_blog_comment_id_fk", column: "parent_blog_comment_id"
  add_foreign_key "blog_comments", "blog_posts", name: "blog_comments_blog_post_id_fk"
  add_foreign_key "blog_comments", "users", name: "blog_comments_user_id_fk"

  add_foreign_key "blog_post_tags", "blog_posts", name: "blog_post_tags_blog_post_id_fk"
  add_foreign_key "blog_post_tags", "tags", name: "blog_post_tags_tag_id_fk"

  add_foreign_key "blog_posts", "blogs", name: "blog_posts_blog_id_fk"
  add_foreign_key "blog_posts", "users", name: "blog_posts_user_id_fk"

  add_foreign_key "blog_tags", "blogs", name: "blog_tags_blog_id_fk"
  add_foreign_key "blog_tags", "tags", name: "blog_tags_tag_id_fk"

  add_foreign_key "blogs", "users", name: "blogs_user_id_fk"

  add_foreign_key "candidates", "elections", name: "candidates_election_id_fk"
  add_foreign_key "candidates", "users", name: "candidates_user_id_fk"

  add_foreign_key "circoscriziones", "continentes", name: "circoscriziones_continente_id_fk"
  add_foreign_key "circoscriziones", "provincias", name: "circoscriziones_provincia_id_fk"
  add_foreign_key "circoscriziones", "regiones", name: "circoscriziones_regione_id_fk"
  add_foreign_key "circoscriziones", "statos", name: "circoscriziones_stato_id_fk"

  add_foreign_key "comunes", "continentes", name: "comunes_continente_id_fk"
  add_foreign_key "comunes", "regiones", name: "comunes_regione_id_fk"
  add_foreign_key "comunes", "statos", name: "comunes_stato_id_fk"

  add_foreign_key "election_votes", "elections", name: "election_votes_election_id_fk"
  add_foreign_key "election_votes", "users", name: "election_votes_user_id_fk"

  add_foreign_key "elections", "events", name: "elections_event_id_fk"

  add_foreign_key "event_comment_likes", "event_comments", name: "event_comment_likes_event_comment_id_fk"
  add_foreign_key "event_comment_likes", "users", name: "event_comment_likes_user_id_fk"

  add_foreign_key "event_comments", "event_comments", name: "event_comments_parent_event_comment_id_fk", column: "parent_event_comment_id"
  add_foreign_key "event_comments", "events", name: "event_comments_event_id_fk"
  add_foreign_key "event_comments", "users", name: "event_comments_user_id_fk"

  add_foreign_key "events", "event_types", name: "events_event_type_id_fk"
  add_foreign_key "events", "users", name: "events_user_id_fk"

  add_foreign_key "frm_categories", "groups", name: "frm_categories_group_id_fk"

  add_foreign_key "frm_category_tags", "frm_categories", name: "frm_category_tags_frm_category_id_fk"
  add_foreign_key "frm_category_tags", "tags", name: "frm_category_tags_tag_id_fk"

  add_foreign_key "frm_forum_tags", "frm_forums", name: "frm_forum_tags_frm_forum_id_fk"
  add_foreign_key "frm_forum_tags", "tags", name: "frm_forum_tags_tag_id_fk"

  add_foreign_key "frm_forums", "groups", name: "frm_forums_group_id_fk"

  add_foreign_key "frm_groups", "groups", name: "frm_groups_group_id_fk"

  add_foreign_key "frm_topic_tags", "frm_topics", name: "frm_topic_tags_frm_topic_id_fk"
  add_foreign_key "frm_topic_tags", "tags", name: "frm_topic_tags_tag_id_fk"

  add_foreign_key "group_areas", "area_roles", name: "group_areas_area_role_id_fk"
  add_foreign_key "group_areas", "groups", name: "group_areas_group_id_fk"

  add_foreign_key "group_elections", "elections", name: "group_elections_election_id_fk"
  add_foreign_key "group_elections", "groups", name: "group_elections_group_id_fk"

  add_foreign_key "group_invitation_emails", "groups", name: "group_invitation_emails_group_id_fk"

  add_foreign_key "group_invitations", "users", name: "group_invitations_invited_id_fk", column: "invited_id"
  add_foreign_key "group_invitations", "users", name: "group_invitations_inviter_id_fk", column: "inviter_id"

  add_foreign_key "group_partecipation_requests", "group_partecipation_request_statuses", name: "parent_fk"
  add_foreign_key "group_partecipation_requests", "groups", name: "group_partecipation_requests_group_id_fk"
  add_foreign_key "group_partecipation_requests", "users", name: "group_partecipation_requests_user_id_fk"

  add_foreign_key "group_partecipations", "groups", name: "group_partecipations_group_id_fk"
  add_foreign_key "group_partecipations", "partecipation_roles", name: "group_partecipations_partecipation_role_id_fk"
  add_foreign_key "group_partecipations", "users", name: "group_partecipations_user_id_fk"

  add_foreign_key "group_proposals", "groups", name: "group_proposals_group_id_fk"
  add_foreign_key "group_proposals", "proposals", name: "group_proposals_proposal_id_fk"

  add_foreign_key "group_quorums", "groups", name: "group_quorums_group_id_fk"
  add_foreign_key "group_quorums", "quorums", name: "group_quorums_quorum_id_fk"

  add_foreign_key "group_tags", "groups", name: "group_tags_group_id_fk"
  add_foreign_key "group_tags", "tags", name: "group_tags_tag_id_fk"

  add_foreign_key "groups", "interest_borders", name: "groups_interest_border_id_fk"
  add_foreign_key "groups", "partecipation_roles", name: "groups_partecipation_role_id_fk"

  add_foreign_key "integrated_contributes", "proposal_comments", name: "integrated_contributes_proposal_comment_id_fk"
  add_foreign_key "integrated_contributes", "proposal_revisions", name: "integrated_contributes_proposal_revision_id_fk"

  add_foreign_key "meeting_organizations", "groups", name: "meeting_organizations_group_id_fk"

  add_foreign_key "meeting_partecipations", "meetings", name: "meeting_partecipations_meeting_id_fk"
  add_foreign_key "meeting_partecipations", "users", name: "meeting_partecipations_user_id_fk"

  add_foreign_key "meetings", "events", name: "meetings_event_id_fk"
  add_foreign_key "meetings", "places", name: "meetings_place_id_fk"

  add_foreign_key "notification_data", "notifications", name: "notification_data_notification_id_fk"

  add_foreign_key "notifications", "notification_types", name: "notifications_notification_type_id_fk"

  add_foreign_key "old_proposal_presentations", "proposal_lives", name: "old_proposal_presentations_proposal_life_id_fk"
  add_foreign_key "old_proposal_presentations", "users", name: "old_proposal_presentations_user_id_fk"

  add_foreign_key "paragraph_histories", "proposals", name: "paragraph_histories_proposal_id_fk"

  add_foreign_key "paragraphs", "sections", name: "paragraphs_section_id_fk"

  add_foreign_key "partecipation_roles", "groups", name: "partecipation_roles_group_id_fk"
  add_foreign_key "partecipation_roles", "partecipation_roles", name: "partecipation_roles_parent_partecipation_role_id_fk", column: "parent_partecipation_role_id"

  add_foreign_key "post_publishings", "blog_posts", name: "post_publishings_blog_post_id_fk"
  add_foreign_key "post_publishings", "groups", name: "post_publishings_group_id_fk"

  add_foreign_key "proposal_borders", "interest_borders", name: "proposal_borders_interest_border_id_fk"
  add_foreign_key "proposal_borders", "proposals", name: "proposal_borders_proposal_id_fk"

  add_foreign_key "proposal_categories", "proposal_categories", name: "proposal_categories_parent_proposal_category_id_fk", column: "parent_proposal_category_id"

  add_foreign_key "proposal_comment_rankings", "proposal_comments", name: "proposal_comment_rankings_proposal_comment_id_fk"
  add_foreign_key "proposal_comment_rankings", "ranking_types", name: "proposal_comment_rankings_ranking_type_id_fk"
  add_foreign_key "proposal_comment_rankings", "users", name: "proposal_comment_rankings_user_id_fk"

  add_foreign_key "proposal_comment_reports", "proposal_comment_report_types", name: "proposal_comment_reports_proposal_comment_report_type_id_fk"

  add_foreign_key "proposal_comments", "paragraphs", name: "proposal_comments_paragraph_id_fk"
  add_foreign_key "proposal_comments", "proposals", name: "proposal_comments_proposal_id_fk"
  add_foreign_key "proposal_comments", "users", name: "proposal_comments_deleted_user_id_fk"
  add_foreign_key "proposal_comments", "users", name: "proposal_comments_user_id_fk"

  add_foreign_key "proposal_lives", "proposals", name: "proposal_lives_proposal_id_fk"
  add_foreign_key "proposal_lives", "quorums", name: "proposal_lives_quorum_id_fk"

  add_foreign_key "proposal_nicknames", "proposals", name: "proposal_nicknames_proposal_id_fk"
  add_foreign_key "proposal_nicknames", "users", name: "proposal_nicknames_user_id_fk"

  add_foreign_key "proposal_presentations", "proposals", name: "proposal_presentations_proposal_id_fk"
  add_foreign_key "proposal_presentations", "users", name: "proposal_presentations_user_id_fk"

  add_foreign_key "proposal_rankings", "proposals", name: "proposal_rankings_proposal_id_fk"
  add_foreign_key "proposal_rankings", "users", name: "proposal_rankings_user_id_fk"

  add_foreign_key "proposal_revisions", "proposals", name: "proposal_revisions_proposal_id_fk"

  add_foreign_key "proposal_schulze_votes", "proposals", name: "proposal_schulze_votes_proposal_id_fk"

  add_foreign_key "proposal_sections", "proposals", name: "proposal_sections_proposal_id_fk"
  add_foreign_key "proposal_sections", "sections", name: "proposal_sections_section_id_fk"

  add_foreign_key "proposal_supports", "groups", name: "proposal_supports_group_id_fk"
  add_foreign_key "proposal_supports", "proposals", name: "proposal_supports_proposal_id_fk"

  add_foreign_key "proposal_tags", "proposals", name: "proposal_tags_proposal_id_fk"
  add_foreign_key "proposal_tags", "tags", name: "proposal_tags_tag_id_fk"

#  add_foreign_key "proposal_votes", "proposals", name: "proposal_votes_proposal_id_fk"

  add_foreign_key "proposals", "events", name: "proposals_vote_event_id_fk", column: "vote_event_id"
  add_foreign_key "proposals", "events", name: "proposals_vote_period_id_fk", column: "vote_period_id"
  add_foreign_key "proposals", "proposal_categories", name: "proposals_proposal_category_id_fk"
  add_foreign_key "proposals", "proposal_states", name: "proposals_proposal_state_id_fk"
  add_foreign_key "proposals", "proposal_types", name: "proposals_proposal_type_id_fk"
  add_foreign_key "proposals", "proposal_votation_types", name: "proposals_proposal_votation_type_id_fk"
  add_foreign_key "proposals", "quorums", name: "proposals_quorum_id_fk"

  add_foreign_key "provincias", "continentes", name: "provincias_continente_id_fk"
  add_foreign_key "provincias", "statos", name: "provincias_stato_id_fk"

  add_foreign_key "quorums", "quorums", name: "quorums_quorum_id_fk"

  add_foreign_key "regiones", "continentes", name: "regiones_continente_id_fk"
  add_foreign_key "regiones", "statos", name: "regiones_stato_id_fk"

  add_foreign_key "revision_section_histories", "proposal_revisions", name: "revision_section_histories_proposal_revision_id_fk"
  add_foreign_key "revision_section_histories", "section_histories", name: "revision_section_histories_section_history_id_fk"

  add_foreign_key "schulze_votes", "elections", name: "schulze_votes_election_id_fk"

  add_foreign_key "simple_votes", "candidates", name: "simple_votes_candidate_id_fk"

  add_foreign_key "solution_histories", "proposal_revisions", name: "solution_histories_proposal_revision_id_fk"

  add_foreign_key "solution_section_histories", "section_histories", name: "solution_section_histories_section_history_id_fk"
  add_foreign_key "solution_section_histories", "solution_histories", name: "solution_section_histories_solution_history_id_fk"

  add_foreign_key "solution_sections", "sections", name: "solution_sections_section_id_fk"
  add_foreign_key "solution_sections", "solutions", name: "solution_sections_solution_id_fk"

  add_foreign_key "solutions", "proposals", name: "solutions_proposal_id_fk"

  add_foreign_key "statos", "continentes", name: "statos_continente_id_fk"

  add_foreign_key "supporters", "candidates", name: "supporters_candidate_id_fk"
  add_foreign_key "supporters", "groups", name: "supporters_group_id_fk"

  add_foreign_key "sys_movements", "sys_currencies", name: "sys_movements_sys_currency_id_fk"
  add_foreign_key "sys_movements", "sys_movement_types", name: "sys_movements_sys_movement_type_id_fk"
  add_foreign_key "sys_movements", "users", name: "sys_movements_user_id_fk"

  add_foreign_key "sys_payment_notifications", "sys_features", name: "sys_payment_notifications_sys_feature_id_fk"

  add_foreign_key "tutorial_assignees", "tutorials", name: "tutorial_assignees_tutorial_id_fk"
  add_foreign_key "tutorial_assignees", "users", name: "tutorial_assignees_user_id_fk"

  add_foreign_key "tutorial_progresses", "steps", name: "tutorial_progresses_step_id_fk"
  add_foreign_key "tutorial_progresses", "users", name: "tutorial_progresses_user_id_fk"

  add_foreign_key "user_alerts", "notifications", name: "user_alerts_notification_id_fk"
  add_foreign_key "user_alerts", "users", name: "user_alerts_user_id_fk"

  add_foreign_key "user_borders", "interest_borders", name: "user_borders_interest_border_id_fk"
  add_foreign_key "user_borders", "users", name: "user_borders_user_id_fk"

  add_foreign_key "user_follows", "users", name: "user_follows_followed_id_fk", column: "followed_id"
  add_foreign_key "user_follows", "users", name: "user_follows_follower_id_fk", column: "follower_id"

  add_foreign_key "user_likes", "users", name: "user_likes_user_id_fk"

  add_foreign_key "user_sensitives", "interest_borders", name: "user_sensitives_birth_place_id_fk", column: "birth_place_id"
  add_foreign_key "user_sensitives", "interest_borders", name: "user_sensitives_home_place_id_fk", column: "home_place_id"
  add_foreign_key "user_sensitives", "interest_borders", name: "user_sensitives_residence_place_id_fk", column: "residence_place_id"
  add_foreign_key "user_sensitives", "sys_document_types", name: "user_sensitives_sys_document_type_id_fk"
  add_foreign_key "user_sensitives", "users", name: "user_sensitives_user_id_fk"

  add_foreign_key "user_votes", "users", name: "user_votes_user_id_fk"
  add_foreign_key "user_votes", "vote_types", name: "user_votes_vote_type_id_fk"

  add_foreign_key "users", "images", name: "users_image_id_fk"


end
