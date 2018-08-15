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

ActiveRecord::Schema.define(version: 20180815113359) do

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "owner_id"
    t.integer  "owner_id_id"
    t.index ["owner_id"], name: "index_comments_on_owner_id"
    t.index ["owner_id_id"], name: "index_comments_on_owner_id_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "gender"
    t.integer  "info_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["info_id"], name: "index_users_on_info_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
