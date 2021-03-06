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

ActiveRecord::Schema.define(version: 20141112015812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: true do |t|
    t.text     "comment"
    t.boolean  "chosen",     default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
  end

  add_index "notes", ["problem_id"], name: "index_notes_on_problem_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "problems", force: true do |t|
    t.text     "issue"
    t.text     "try"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resolved",            default: false
    t.string   "screen_file_name"
    t.string   "screen_content_type"
    t.integer  "screen_file_size"
    t.datetime "screen_updated_at"
  end

  add_index "problems", ["user_id"], name: "index_problems_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "activation_key"
    t.boolean  "activated",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
