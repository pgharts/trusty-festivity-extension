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

ActiveRecord::Schema.define(version: 201604261638542263) do

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

  create_table "festivity_categories", force: :cascade do |t|
    t.string  "name",                       limit: 255
    t.integer "festivity_category_type_id", limit: 4
    t.integer "parent_id",                  limit: 4
    t.integer "position",                   limit: 4
    t.boolean "inactive",                               default: false
  end

  create_table "festivity_category_types", force: :cascade do |t|
    t.string  "name",       limit: 255
    t.integer "site_id",    limit: 4
    t.integer "position",   limit: 4
    t.string  "page_class", limit: 255
    t.boolean "inactive",               default: false
  end

  create_table "festivity_event_performances", id: false, force: :cascade do |t|
    t.integer  "performance_id",           limit: 4,   default: 0, null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "event_id",                 limit: 4,   default: 0, null: false
    t.string   "event_title",              limit: 255
    t.string   "short_description",        limit: 255
    t.string   "buy_url",                  limit: 255
    t.boolean  "featured_item"
    t.string   "header",                   limit: 255
    t.string   "sub_header",               limit: 255
    t.integer  "site_id",                  limit: 4
    t.integer  "location_id",              limit: 4,   default: 0, null: false
    t.string   "location_slug",            limit: 100
    t.string   "location_title",           limit: 255
    t.string   "festivity_directions_url", limit: 255
    t.integer  "area_id",                  limit: 4,   default: 0, null: false
    t.string   "area_slug",                limit: 100
    t.string   "area_title",               limit: 255
  end

  create_table "festivity_market_details", id: false, force: :cascade do |t|
    t.integer  "market_id",         limit: 4,   default: 0, null: false
    t.string   "market_title",      limit: 255
    t.string   "short_description", limit: 255
    t.string   "header",            limit: 255
    t.string   "sub_header",        limit: 255
    t.integer  "site_id",           limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "area_id",           limit: 4,   default: 0, null: false
    t.string   "area_slug",         limit: 100
    t.string   "area_title",        limit: 255
  end

  create_table "festivity_page_categories", force: :cascade do |t|
    t.integer "page_id",               limit: 4
    t.integer "festivity_category_id", limit: 4
  end

  add_index "festivity_page_categories", ["page_id", "festivity_category_id"], name: "event_categories", unique: true, using: :btree

  create_table "festivity_performances", force: :cascade do |t|
    t.integer  "event_page_id",    limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "location_page_id", limit: 4
    t.string   "notes",            limit: 255, default: ""
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "festivity_performances", ["event_page_id"], name: "index_festivity_performances_on_event_page_id", using: :btree
  add_index "festivity_performances", ["location_page_id"], name: "index_festivity_performances_on_location_page_id", using: :btree

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
    t.string   "title",                    limit: 255
    t.string   "slug",                     limit: 100
    t.string   "breadcrumb",               limit: 160
    t.string   "class_name",               limit: 25
    t.integer  "status_id",                limit: 4,     default: 1,     null: false
    t.integer  "parent_id",                limit: 4
    t.integer  "layout_id",                limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "created_by_id",            limit: 4
    t.integer  "updated_by_id",            limit: 4
    t.boolean  "virtual",                                default: false, null: false
    t.integer  "lock_version",             limit: 4,     default: 0
    t.text     "allowed_children_cache",   limit: 65535
    t.integer  "site_id",                  limit: 4
    t.integer  "position",                 limit: 4
    t.string   "short_description",        limit: 255
    t.string   "artist_twitter",           limit: 255
    t.string   "artist_facebook",          limit: 255
    t.string   "artist_instagram",         limit: 255
    t.string   "artist_homepage",          limit: 255
    t.string   "header",                   limit: 255
    t.string   "sub_header",               limit: 255
    t.string   "redirect_url",             limit: 255
    t.boolean  "featured_item"
    t.string   "buy_url",                  limit: 255
    t.string   "booth_number",             limit: 255
    t.integer  "area_id",                  limit: 4
    t.string   "festivity_address",        limit: 255
    t.string   "festivity_city",           limit: 255
    t.string   "festivity_state",          limit: 255
    t.string   "festivity_zip",            limit: 255
    t.string   "festivity_directions_url", limit: 255
    t.string   "vanity_url",               limit: 255
    t.string   "target_url",               limit: 255
    t.boolean  "hide_from_subnav",                       default: false
    t.datetime "market_start_date"
    t.datetime "market_end_date"
  end

  add_index "pages", ["class_name"], name: "pages_class_name", using: :btree
  add_index "pages", ["parent_id"], name: "pages_parent_id", using: :btree
  add_index "pages", ["site_id"], name: "index_pages_on_site_id", using: :btree
  add_index "pages", ["slug", "parent_id"], name: "pages_child_slug", using: :btree
  add_index "pages", ["virtual", "status_id"], name: "pages_published", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255
    t.text     "data",       limit: 65535
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "domain",                    limit: 255
    t.integer  "homepage_id",               limit: 4
    t.integer  "position",                  limit: 4,   default: 0
    t.string   "base_domain",               limit: 255
    t.integer  "created_by_id",             limit: 4
    t.datetime "created_at"
    t.integer  "updated_by_id",             limit: 4
    t.datetime "updated_at"
    t.string   "subtitle",                  limit: 255
    t.string   "abbreviation",              limit: 255
    t.datetime "festivity_start_date"
    t.datetime "festivity_end_date"
    t.string   "festivity_festival_name",   limit: 255
    t.string   "festivity_google_api_key",  limit: 255
    t.string   "festivity_filter_type",     limit: 255
    t.string   "festivity_buy_ticket_text", limit: 255, default: "Buy Tickets"
    t.string   "social_media_tag",          limit: 255
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
