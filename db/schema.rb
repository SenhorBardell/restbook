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

ActiveRecord::Schema.define(version: 20150414184553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_devices", force: :cascade do |t|
    t.string  "udid"
    t.string  "auth"
    t.integer "place_id"
    t.string  "token"
  end

  create_table "areas", force: :cascade do |t|
    t.integer "place_id"
    t.string  "area_type", default: "table"
  end

  create_table "codes", force: :cascade do |t|
    t.string   "code"
    t.string   "token"
    t.datetime "created_at"
    t.integer  "device_id"
  end

  add_index "codes", ["device_id"], name: "index_codes_on_device_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string  "token"
    t.string  "auth"
    t.boolean "verified", default: false
    t.integer "user_id"
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "datetime"
    t.string   "info"
    t.string   "guests"
    t.string   "status",     default: "pending"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "area_id"
  end

  add_index "orders", ["area_id"], name: "index_orders_on_area_id", using: :btree
  add_index "orders", ["place_id"], name: "index_orders_on_place_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string  "logo"
    t.string  "place_type"
    t.string  "name"
    t.string  "img"
    t.string  "desc"
    t.string  "city"
    t.string  "street"
    t.string  "building"
    t.integer "long"
    t.integer "lat"
    t.json    "hours"
    t.string  "flags",      array: true
    t.string  "pass"
    t.string  "login"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "text"
    t.integer  "vote",       limit: 2
    t.datetime "created_at"
  end

  add_index "reviews", ["place_id"], name: "index_reviews_on_place_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone", limit: 11
  end

end
