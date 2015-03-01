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

ActiveRecord::Schema.define(version: 20150226073617) do

  create_table "codes", force: :cascade do |t|
    t.string   "code"
    t.string   "token"
    t.datetime "created_at", default: '2015-03-01 18:11:13'
    t.integer  "device_id"
  end

  add_index "codes", ["device_id"], name: "index_codes_on_device_id"

  create_table "devices", force: :cascade do |t|
    t.string  "token"
    t.string  "auth"
    t.boolean "verified", default: false
    t.integer "user_id"
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id"

  create_table "places", force: :cascade do |t|
    t.string  "logo"
    t.string  "type"
    t.string  "name"
    t.string  "img"
    t.string  "desc"
    t.string  "city"
    t.string  "street"
    t.integer "long"
    t.integer "lat"
    t.boolean "can_book"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone", limit: 11
  end

end
