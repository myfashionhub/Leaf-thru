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

ActiveRecord::Schema.define(version: 20180623214203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text     "url"
    t.string   "title",       limit: 255
    t.string   "publication", limit: 255
    t.text     "extract"
    t.string   "date",        limit: 255
    t.string   "shared_by",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "reader_id"
    t.integer "article_id"
    t.integer "match_score"
    t.integer "reader_ranking"
    t.string  "pocket_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.string   "topic",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "readers", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "email_validate",       limit: 255
    t.string   "password",             limit: 255
    t.string   "location",             limit: 255
    t.string   "twitter_token",        limit: 255
    t.string   "twitter_token_secret", limit: 255
    t.string   "twitter_handle",       limit: 255
    t.string   "facebook_token",       limit: 255
    t.string   "facebook_uid",         limit: 255
    t.string   "tagline",              limit: 255
    t.string   "image",                limit: 255
    t.string   "email",                limit: 255, null: false
    t.string   "crypted_password",     limit: 255, null: false
    t.string   "salt",                 limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pocket_token",         limit: 255
    t.string   "pocket_username",      limit: 255
  end

  add_index "readers", ["email"], name: "index_readers_on_email", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "reader_id"
    t.integer  "publication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
