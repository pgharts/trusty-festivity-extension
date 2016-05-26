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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151029130042) do

  create_table "api_keys", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "api_key",    limit: 255
    t.boolean  "active",                 default: true
    t.string   "notes",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", force: :cascade do |t|
    t.string   "caption",            limit: 255
    t.string   "title",              limit: 255
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.integer  "created_by_id",      limit: 4
    t.integer  "updated_by_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",               limit: 255
    t.integer  "original_width",     limit: 4
    t.integer  "original_height",    limit: 4
    t.string   "original_extension", limit: 255
  end

  create_table "config", force: :cascade do |t|
    t.string "key",   limit: 40,  default: "", null: false
    t.string "value", limit: 255, default: ""
  end

  add_index "config", ["key"], name: "key", unique: true, using: :btree

  create_table "extension_meta", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "schema_version", limit: 4,   default: 0
    t.boolean "enabled",                    default: true
  end

  create_table "facility_days_open", force: :cascade do |t|
    t.integer "facility_page_id", limit: 4
    t.boolean "sunday",                     default: false
    t.boolean "monday",                     default: false
    t.boolean "tuesday",                    default: false
    t.boolean "wednesday",                  default: false
    t.boolean "thursday",                   default: false
    t.boolean "friday",                     default: false
    t.boolean "saturday",                   default: false
  end

  create_table "flex_package_details", force: :cascade do |t|
    t.boolean  "seated_indicator"
    t.integer  "flex_package_page_id", limit: 4
    t.integer  "min_performances",     limit: 4
    t.integer  "max_performances",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exchange_rule_id",     limit: 4,   default: 2
    t.integer  "exempt_fee_id",        limit: 4
    t.string   "presenter",            limit: 255
    t.integer  "parking_package_id",   limit: 4
    t.string   "eligible_season_ids",  limit: 255
  end

  create_table "flex_simple_zone_templates", force: :cascade do |t|
    t.integer  "flex_package_page_id", limit: 4
    t.integer  "production_page_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forced_add_ons", force: :cascade do |t|
    t.integer  "package_detail_id", limit: 4, null: false
    t.integer  "performance_id",    limit: 4, null: false
    t.integer  "price_type_id",     limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_certificate_types", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.integer  "payment_method", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fee_number",     limit: 4
    t.string   "description",    limit: 255
  end

  create_table "gift_certificate_types_sites", id: false, force: :cascade do |t|
    t.integer  "site_id",                  limit: 4
    t.integer  "gift_certificate_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "layouts", force: :cascade do |t|
    t.string   "name",          limit: 100
    t.text     "content",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.string   "content_type",  limit: 40
    t.integer  "lock_version",  limit: 4,     default: 0
    t.integer  "site_id",       limit: 4
  end

  create_table "non_ticketed_performances", force: :cascade do |t|
    t.integer  "non_ticketed_event_page_id", limit: 4
    t.datetime "date"
    t.string   "venue_id",                   limit: 255
    t.string   "notes",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "package_details", force: :cascade do |t|
    t.boolean  "seated_indicator"
    t.integer  "package_page_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parking_package_id",    limit: 4
    t.integer  "restaurant_package_id", limit: 4
    t.integer  "exchange_rule_id",      limit: 4,   default: 2
    t.integer  "exempt_fee_id",         limit: 4
    t.string   "presenter",             limit: 255
    t.string   "eligible_season_ids",   limit: 255
  end

  create_table "package_details_add_on_productions", id: false, force: :cascade do |t|
    t.integer  "package_detail_id",  limit: 4
    t.integer  "production_page_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "package_pages_performances", id: false, force: :cascade do |t|
    t.integer  "package_page_id", limit: 4
    t.integer  "performance_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_attachments", force: :cascade do |t|
    t.integer "asset_id", limit: 4
    t.integer "page_id",  limit: 4
    t.integer "position", limit: 4
  end

  create_table "page_fields", force: :cascade do |t|
    t.integer "page_id", limit: 4
    t.string  "name",    limit: 255
    t.string  "content", limit: 255
  end

  add_index "page_fields", ["page_id", "name", "content"], name: "index_page_fields_on_page_id_and_name_and_content", using: :btree

  create_table "page_parts", force: :cascade do |t|
    t.string  "name",      limit: 100
    t.string  "filter_id", limit: 25
    t.text    "content",   limit: 16777215
    t.integer "page_id",   limit: 4
  end

  add_index "page_parts", ["page_id", "name"], name: "parts_by_page", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",                               limit: 255
    t.string   "slug",                                limit: 100
    t.string   "breadcrumb",                          limit: 160
    t.string   "class_name",                          limit: 35
    t.integer  "status_id",                           limit: 4,     default: 1,     null: false
    t.integer  "parent_id",                           limit: 4
    t.integer  "layout_id",                           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "created_by_id",                       limit: 4
    t.integer  "updated_by_id",                       limit: 4
    t.boolean  "virtual",                                           default: false, null: false
    t.integer  "lock_version",                        limit: 4,     default: 0
    t.text     "allowed_children_cache",              limit: 65535
    t.integer  "site_id",                             limit: 4
    t.integer  "position",                            limit: 4
    t.integer  "production_id",                       limit: 4
    t.string   "production_name",                     limit: 255
    t.integer  "organization_id",                     limit: 4
    t.boolean  "select_your_own_seat",                              default: true
    t.string   "reason_select_your_own_seat_disable", limit: 255
    t.boolean  "enable_captcha",                                    default: false
    t.boolean  "flex",                                              default: false
    t.integer  "purchase_path_capacity",              limit: 4
    t.string   "venue_id",                            limit: 255
    t.string   "buy_url",                             limit: 255
    t.string   "genre",                               limit: 255
    t.date     "carousel_expiry_date"
    t.boolean  "group_sales_enabled",                               default: true
    t.boolean  "best_available_for_group_sales",                    default: false
    t.integer  "season_id",                           limit: 4
    t.integer  "group_sales_min_seats",               limit: 4,     default: 10
    t.integer  "group_sales_max_seats",               limit: 4,     default: 30
    t.boolean  "tickets_donatable",                                 default: true
    t.string   "fee_notes",                           limit: 255
    t.integer  "best_available_max_seats",            limit: 4,     default: 9
    t.string   "renewal_season_ids",                  limit: 255
    t.boolean  "donation",                                          default: true
    t.boolean  "enable_customer_seating",                           default: false
    t.boolean  "enable_print_at_home",                              default: false
    t.string   "ticket_prices",                       limit: 255
    t.string   "presenter_name",                      limit: 255
    t.string   "presenter_phone",                     limit: 255
    t.boolean  "display_on_org_calendar",                           default: true
    t.boolean  "display_on_district_calendar",                      default: true
    t.string   "google_map_url",                      limit: 255
    t.string   "config_folder",                       limit: 255
    t.string   "street_address",                      limit: 255
    t.string   "city",                                limit: 255
    t.string   "state",                               limit: 255
    t.string   "zip_code",                            limit: 255
    t.string   "facility_phone",                      limit: 255
    t.datetime "exhibit_start_date"
    t.datetime "exhibit_end_date"
    t.boolean  "use_simple_zone_selection",                         default: false
    t.string   "redirect_url",                        limit: 255
    t.string   "show_notes",                          limit: 255
    t.integer  "template_id",                         limit: 4
    t.string   "vanity_url",                          limit: 255
    t.string   "target_url",                          limit: 255
    t.string   "media_tags",                          limit: 255,   default: ""
    t.boolean  "audio_described",                                   default: false
    t.boolean  "braille",                                           default: false
    t.boolean  "captioned",                                         default: false
    t.boolean  "large_print",                                       default: false
    t.boolean  "wheelchair",                                        default: false
    t.boolean  "sensory_friendly",                                  default: false
    t.boolean  "signed",                                            default: false
    t.boolean  "assistive_listening",                               default: false
    t.boolean  "enable_accessible_seating",                         default: false
    t.string   "forced_donation",                     limit: 255,   default: ""
    t.string   "source_no",                           limit: 255,   default: ""
    t.boolean  "hide_payment_plan",                                 default: false
    t.string   "ticket_text_1",                       limit: 255,   default: ""
    t.string   "ticket_text_2",                       limit: 255,   default: ""
    t.string   "override_onsale_message",             limit: 255,   default: ""
    t.string   "run_time",                            limit: 255,   default: ""
    t.text     "hours",                               limit: 65535
  end

  add_index "pages", ["class_name"], name: "pages_class_name", using: :btree
  add_index "pages", ["parent_id"], name: "pages_parent_id", using: :btree
  add_index "pages", ["site_id"], name: "index_pages_on_site_id", using: :btree
  add_index "pages", ["slug", "parent_id"], name: "pages_child_slug", using: :btree
  add_index "pages", ["virtual", "status_id"], name: "pages_published", using: :btree

  create_table "performance_groups", force: :cascade do |t|
    t.integer  "flex_package_detail_id", limit: 4
    t.string   "description",            limit: 255
    t.integer  "min_performances",       limit: 4
    t.integer  "max_performances",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number",                 limit: 4
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "production_page_id",        limit: 4
    t.datetime "date"
    t.integer  "venue_id",                  limit: 4
    t.boolean  "on_sale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "parking_performance_id",    limit: 4,   default: 0
    t.integer  "mode_of_sale",              limit: 4
    t.string   "notes",                     limit: 255
    t.integer  "restaurant_performance_id", limit: 4,   default: 0
  end

  create_table "performances_and_performance_groups", id: false, force: :cascade do |t|
    t.integer "performance_id",       limit: 4
    t.integer "performance_group_id", limit: 4
  end

  create_table "presenters", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "phone",              limit: 255
    t.integer  "production_page_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "renewal_pages", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255
    t.text     "data",       limit: 65535
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",                                 limit: 255
    t.string   "domain",                               limit: 255
    t.integer  "homepage_id",                          limit: 4
    t.integer  "position",                             limit: 4,   default: 0
    t.string   "base_domain",                          limit: 255
    t.integer  "created_by_id",                        limit: 4
    t.datetime "created_at"
    t.integer  "updated_by_id",                        limit: 4
    t.datetime "updated_at"
    t.string   "subtitle",                             limit: 255
    t.string   "abbreviation",                         limit: 255
    t.integer  "organization_id",                      limit: 4
    t.string   "organization_name",                    limit: 255
    t.boolean  "show_on_carousel",                                 default: false
    t.integer  "contribution_account_id",              limit: 4
    t.boolean  "is_district_organization"
    t.boolean  "show_all_district_organizations"
    t.integer  "subscription_mode_of_sale",            limit: 4
    t.string   "box_office_phone_number",              limit: 255
    t.integer  "carousel_item_count",                  limit: 4,   default: 1
    t.integer  "forgot_password_template_id",          limit: 4
    t.string   "group_sales_phone_number",             limit: 255
    t.float    "exchange_fee",                         limit: 24,  default: 0.0
    t.string   "notes",                                limit: 255
    t.integer  "channel",                              limit: 4
    t.integer  "subscription_mos",                     limit: 4
    t.boolean  "enable_print_at_home",                             default: false
    t.string   "subscription_box_office_phone_number", limit: 255
    t.string   "mail2_api_key",                        limit: 255
    t.integer  "mail2_list_id",                        limit: 4
    t.integer  "mobile_channel",                       limit: 4,   default: 33
    t.string   "google_search_api_key",                limit: 255, default: "004905679161489350096%3Arymp5afccji"
    t.string   "flickr_api_key",                       limit: 255, default: "064cd1ea3aa2545e9197219f7bfe45c2"
    t.string   "flickr_shared_secret",                 limit: 255, default: "f0cd7c1ab262d7de"
    t.string   "flickr_user_id",                       limit: 255, default: ""
    t.string   "vimeo_consumer_key",                   limit: 255, default: "06cf6b6a766471702fc83b2a4bcf7e7a1343d2c2"
    t.string   "vimeo_consumer_secret",                limit: 255, default: "df1fb5bdbf4546fcdc9b0b76161242fbd5a1c07e"
    t.string   "vimeo_access_token",                   limit: 255, default: "5fdc916437fb9cf775baf5a7e389a24c"
    t.string   "vimeo_access_token_secret",            limit: 255, default: "c84857e30b2b0c4b419f89da682922ba8a8d94ff"
    t.string   "vimeo_user_id",                        limit: 255, default: ""
    t.boolean  "round_up_donations",                               default: true
  end

  create_table "snippets", force: :cascade do |t|
    t.string   "name",          limit: 100,   default: "", null: false
    t.string   "filter_id",     limit: 25
    t.text     "content",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.integer  "lock_version",  limit: 4,     default: 0
    t.integer  "site_id",       limit: 4
  end

  add_index "snippets", ["name", "site_id"], name: "name_site_id", unique: true, using: :btree

  create_table "sync_logs", force: :cascade do |t|
    t.string   "entity",      limit: 255
    t.string   "level",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 100
    t.string   "email",         limit: 255
    t.string   "login",         limit: 40,    default: "",    null: false
    t.string   "password",      limit: 40
    t.boolean  "admin",                       default: false, null: false
    t.boolean  "designer",                    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.string   "salt",          limit: 255
    t.text     "notes",         limit: 65535
    t.integer  "lock_version",  limit: 4,     default: 0
    t.string   "session_token", limit: 255
    t.string   "locale",        limit: 255
    t.integer  "site_id",       limit: 4
  end

end
