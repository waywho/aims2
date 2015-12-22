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

ActiveRecord::Schema.define(version: 20151222205405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accompanists", force: :cascade do |t|
    t.string   "name"
    t.text     "biography"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "accompanists", ["slug"], name: "index_accompanists_on_slug", using: :btree

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

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug"
    t.integer  "format_id"
    t.integer  "draft_id"
    t.datetime "published_at"
    t.string   "workflow_state"
  end

  add_index "courses", ["format_id"], name: "index_courses_on_format_id", using: :btree
  add_index "courses", ["slug"], name: "index_courses_on_slug", using: :btree

  create_table "drafts", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "previous_draft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drafts", ["created_at"], name: "index_drafts_on_created_at", using: :btree
  add_index "drafts", ["event"], name: "index_drafts_on_event", using: :btree
  add_index "drafts", ["item_id"], name: "index_drafts_on_item_id", using: :btree
  add_index "drafts", ["item_type"], name: "index_drafts_on_item_type", using: :btree
  add_index "drafts", ["updated_at"], name: "index_drafts_on_updated_at", using: :btree
  add_index "drafts", ["whodunnit"], name: "index_drafts_on_whodunnit", using: :btree

  create_table "formats", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  add_index "formats", ["slug"], name: "index_formats_on_slug", using: :btree

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "repertoire"
    t.integer  "number_of_sessions"
    t.string   "session_of_day"
    t.integer  "course_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "klasses", ["course_id"], name: "index_klasses_on_course_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

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

  create_table "tutors", force: :cascade do |t|
    t.string   "name"
    t.text     "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "photo"
    t.string   "slug"
  end

  add_index "tutors", ["slug"], name: "index_tutors_on_slug", using: :btree

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
