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

ActiveRecord::Schema.define(version: 20180824110821) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "dbpost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dbpost_id"], name: "index_comments_on_dbpost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dbposts", force: :cascade do |t|
    t.string   "menu"
    t.string   "school"
    t.string   "title"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "now_cnt",      default: 1
    t.integer  "fill_cnt"
    t.datetime "start_time"
    t.string   "select_style"
    t.string   "select_eat"
    t.string   "hope_gender"
    t.index ["user_id"], name: "index_dbposts_on_user_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.text     "params"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "infos", force: :cascade do |t|
    t.integer  "dbpost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dbpost_id"], name: "index_infos_on_dbpost_id"
  end

  create_table "notices", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "content"
    t.boolean  "notice",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "choice"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "gender"
    t.integer  "info_id"
    t.string   "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["info_id"], name: "index_users_on_info_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
