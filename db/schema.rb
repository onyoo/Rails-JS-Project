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

ActiveRecord::Schema.define(version: 5) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "usability_rating"
    t.integer  "addictive_rating"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "ratings", ["resource_id"], name: "index_ratings_on_resource_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.decimal  "price_per_month"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "member_status",   default: "Little Grasshopper"
    t.string   "password_digest"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

end
