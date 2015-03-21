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

ActiveRecord::Schema.define(version: 20150321190709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_devices", force: :cascade do |t|
    t.string  "udid"
    t.string  "auth"
    t.integer "place_id"
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
    t.string   "table"
  end

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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone", limit: 11
  end

end
