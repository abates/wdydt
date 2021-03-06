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

ActiveRecord::Schema.define(version: 20160426123021) do

  create_table "activities", force: :cascade do |t|
    t.date     "day"
    t.integer  "actable_id"
    t.string   "actable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "activity_fields", force: :cascade do |t|
    t.integer  "activity_type_id"
    t.string   "name"
    t.string   "field_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "activity_fields", ["activity_type_id"], name: "index_activity_fields_on_activity_type_id"

  create_table "activity_types", force: :cascade do |t|
    t.string   "name"
    t.string   "class_name"
    t.string   "plural_description"
    t.string   "singular_description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "activity_validators", force: :cascade do |t|
    t.integer  "activity_type_id"
    t.integer  "activity_field_id"
    t.text     "description"
    t.text     "formula"
    t.text     "message"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "activity_validators", ["activity_field_id"], name: "index_activity_validators_on_activity_field_id"
  add_index "activity_validators", ["activity_type_id"], name: "index_activity_validators_on_activity_type_id"

  create_table "expenses", force: :cascade do |t|
    t.string  "category"
    t.decimal "amount"
    t.text    "notes"
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "mileage", force: :cascade do |t|
    t.decimal "distance"
    t.string  "origin"
    t.string  "destination"
    t.text    "notes"
  end

  create_table "tasks", force: :cascade do |t|
    t.string  "task"
    t.decimal "hours"
    t.text    "notes"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "email",                  default: ""
    t.string   "name"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
