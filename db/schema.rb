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

ActiveRecord::Schema.define(version: 20160111105104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "casein_admin_users", force: :cascade do |t|
    t.string   "login",                           null: false
    t.string   "name"
    t.string   "email"
    t.integer  "access_level",        default: 0, null: false
    t.string   "crypted_password",                null: false
    t.string   "password_salt",                   null: false
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         default: 0, null: false
    t.integer  "failed_login_count",  default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_formats", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.string   "workflow_state"
    t.text     "whats_new"
    t.datetime "when_from"
    t.datetime "when_to"
    t.string   "venue"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "post_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "published_at"
  end

  add_index "course_formats", ["slug"], name: "index_course_formats_on_slug", using: :btree

  create_table "courseformats", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.string   "workflow_state"
    t.text     "whats_new"
    t.datetime "when_from"
    t.datetime "when_to"
    t.string   "venue"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "post_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "published_at"
  end

  add_index "courseformats", ["slug"], name: "index_courseformats_on_slug", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.string   "workflow_state"
    t.datetime "published_at"
    t.integer  "courseformat_id"
  end

  add_index "courses", ["courseformat_id"], name: "index_courses_on_courseformat_id", using: :btree
  add_index "courses", ["slug"], name: "index_courses_on_slug", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "programme"
    t.text     "performers"
    t.datetime "date"
    t.string   "slug"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "workflow_state"
    t.string   "venue"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "post_code"
    t.string   "ticket_type"
    t.datetime "published_at"
  end

  create_table "fees", force: :cascade do |t|
    t.string   "fee_type"
    t.string   "category"
    t.string   "description"
    t.integer  "amount"
    t.string   "workflow_state"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "published_at"
    t.integer  "courseformat_id"
  end

  add_index "fees", ["courseformat_id"], name: "index_fees_on_courseformat_id", using: :btree

  create_table "highlights", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "courseformat_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "repertoire"
    t.integer  "number_of_sessions"
    t.string   "session_of_day"
    t.integer  "course_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "workflow_state"
    t.datetime "published_at"
  end

  add_index "klasses", ["course_id"], name: "index_klasses_on_course_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "menu_type"
    t.string   "navigation_type"
    t.integer  "navigation_id"
    t.integer  "row_order"
  end

  add_index "menus", ["ancestry"], name: "index_menus_on_ancestry", using: :btree
  add_index "menus", ["navigation_id"], name: "index_menus_on_navigation_id", using: :btree
  add_index "menus", ["navigation_type"], name: "index_menus_on_navigation_type", using: :btree
  add_index "menus", ["row_order"], name: "index_menus_on_row_order", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug"
    t.string   "workflow_state"
    t.integer  "leader_id"
    t.integer  "leader_type"
    t.datetime "published_at"
  end

  add_index "pages", ["leader_id"], name: "index_pages_on_leader_id", using: :btree
  add_index "pages", ["leader_type"], name: "index_pages_on_leader_type", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "photos", force: :cascade do |t|
    t.text     "caption"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "image"
  end

  add_index "photos", ["imageable_id"], name: "index_photos_on_imageable_id", using: :btree
  add_index "photos", ["imageable_type"], name: "index_photos_on_imageable_type", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.string   "author"
    t.string   "saying"
    t.string   "workflow_state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "published_at"
  end

  create_table "recordfies", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "entriable_id"
    t.string   "entriable_type"
    t.integer  "row_order"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "recordfies", ["entriable_type", "entriable_id"], name: "index_recordfies_on_entriable_type_and_entriable_id", using: :btree
  add_index "recordfies", ["row_order"], name: "index_recordfies_on_row_order", using: :btree

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.text     "biography"
    t.string   "role"
    t.string   "slug"
    t.string   "workflow_state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "published_at"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
