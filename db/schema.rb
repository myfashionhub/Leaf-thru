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

ActiveRecord::Schema.define(version: 20140611194608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text "url"
    t.string "title"
    t.string "publication"
    t.text "extract"
    t.string "date"
    t.string "shared_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "reader_id"
    t.integer "article_id"
    t.integer "match_score"
    t.integer "reader_ranking"
    t.string "pocket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "readers", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "location"
    t.string "tagline"
    t.string "image"
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt", null: false
    t.string "facebook_token"
    t.string "facebook_uid"
    t.string "pocket_token"
    t.string "pocket_username"
    t.string "twitter_token"
    t.string "twitter_token_secret"
    t.string "twitter_handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_readers_on_email", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "reader_id"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
