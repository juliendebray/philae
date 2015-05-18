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

ActiveRecord::Schema.define(version: 20150513151840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "destinations", force: true do |t|
    t.float    "ne_lat"
    t.float    "ne_lng"
    t.float    "sw_lat"
    t.float    "sw_lng"
    t.string   "name"
    t.text     "overview"
    t.text     "formalities"
    t.text     "regions"
    t.text     "transportation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "country_code"
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
    t.string   "name"
    t.string   "original_date"
  end

  add_index "experience_reviews", ["experience_id"], name: "index_experience_reviews_on_experience_id", using: :btree
  add_index "experience_reviews", ["user_id"], name: "index_experience_reviews_on_user_id", using: :btree

  create_table "experiences", force: true do |t|
    t.text     "address"
    t.string   "name"
    t.text     "description"
    t.boolean  "published",          default: false
    t.integer  "user_id"
    t.boolean  "private"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "average_rating"
    t.boolean  "from_guest_comment", default: false
    t.integer  "trip_comment_id"
    t.boolean  "must_see",           default: false
    t.string   "wikipedia_link"
    t.integer  "nb_votes"
    t.boolean  "thousand_places"
    t.boolean  "unesco"
    t.float    "ta_rating"
    t.integer  "ta_votes"
    t.float    "gg_rating"
    t.integer  "gg_votes"
    t.float    "fsq_rating"
    t.integer  "fsq_votes"
    t.integer  "destination_id"
    t.string   "country_code"
    t.string   "categories_tab"
    t.string   "timetospent"
    t.string   "wheretosleep"
  end

  add_index "experiences", ["category_id"], name: "index_experiences_on_category_id", using: :btree
  add_index "experiences", ["destination_id"], name: "index_experiences_on_destination_id", using: :btree
  add_index "experiences", ["trip_comment_id"], name: "index_experiences_on_trip_comment_id", using: :btree
  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "leader_reviews", force: true do |t|
    t.integer  "experience_id"
    t.string   "source"
    t.text     "comment"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leader_reviews", ["experience_id"], name: "index_leader_reviews_on_experience_id", using: :btree

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "website"
    t.text     "activities_description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "address"
    t.text     "other"
  end

  create_table "recommended_trip_experiences", force: true do |t|
    t.integer  "recommended_trip_id"
    t.integer  "experience_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommended_trip_experiences", ["experience_id"], name: "index_recommended_trip_experiences_on_experience_id", using: :btree
  add_index "recommended_trip_experiences", ["recommended_trip_id"], name: "index_recommended_trip_experiences_on_recommended_trip_id", using: :btree

  create_table "recommended_trips", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "destination_id"
  end

  add_index "recommended_trips", ["destination_id"], name: "index_recommended_trips_on_destination_id", using: :btree

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
    t.boolean  "add_to_trip",   default: false
    t.integer  "experience_id"
  end

  add_index "trip_comments", ["experience_id"], name: "index_trip_comments_on_experience_id", using: :btree
  add_index "trip_comments", ["trip_id"], name: "index_trip_comments_on_trip_id", using: :btree
  add_index "trip_comments", ["user_id"], name: "index_trip_comments_on_user_id", using: :btree

  create_table "trip_experiences", force: true do |t|
    t.integer  "trip_id"
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.text     "comment"
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
    t.float    "latitude"
    t.float    "longitude"
    t.string   "token"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "destination_id"
    t.string   "country_code"
    t.float    "vp_ne_lat"
    t.float    "vp_ne_lng"
    t.float    "vp_sw_lat"
    t.float    "vp_sw_lng"
  end

  add_index "trips", ["destination_id"], name: "index_trips_on_destination_id", using: :btree
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
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
