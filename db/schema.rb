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

ActiveRecord::Schema.define(version: 20141217113637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_pictures", force: true do |t|
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "experience_pictures", ["experience_id"], name: "index_experience_pictures_on_experience_id", using: :btree

  create_table "experience_reviews", force: true do |t|
    t.integer  "experience_id"
    t.text     "comment"
    t.float    "rating"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experience_reviews", ["experience_id"], name: "index_experience_reviews_on_experience_id", using: :btree
  add_index "experience_reviews", ["user_id"], name: "index_experience_reviews_on_user_id", using: :btree

  create_table "experiences", force: true do |t|
    t.text     "address"
    t.string   "name"
    t.text     "description"
    t.boolean  "published",    default: false
    t.integer  "user_id"
    t.boolean  "private"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "experiences", ["category_id"], name: "index_experiences_on_category_id", using: :btree
  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "sender_id"
    t.string   "status",     default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id", using: :btree

  create_table "services", force: true do |t|
    t.integer  "experience_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["experience_id"], name: "index_services_on_experience_id", using: :btree
  add_index "services", ["provider_id"], name: "index_services_on_provider_id", using: :btree

  create_table "trip_comments", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.string   "description"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "trip_comments", ["trip_id"], name: "index_trip_comments_on_trip_id", using: :btree
  add_index "trip_comments", ["user_id"], name: "index_trip_comments_on_user_id", using: :btree

  create_table "trip_experiences", force: true do |t|
    t.integer  "trip_id"
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "trip_experiences", ["experience_id"], name: "index_trip_experiences_on_experience_id", using: :btree
  add_index "trip_experiences", ["trip_id"], name: "index_trip_experiences_on_trip_id", using: :btree

  create_table "trips", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query"
    t.float    "query_lat"
    t.float    "query_lng"
    t.string   "token"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "picture"
    t.string   "name"
    t.string   "token"
    t.datetime "token_expiry"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
