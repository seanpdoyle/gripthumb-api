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

ActiveRecord::Schema.define(version: 20131221181614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parts", force: true do |t|
    t.string   "name",       null: false
    t.integer  "song_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parts", ["song_id"], name: "index_parts_on_song_id", using: :btree
  add_index "parts", ["video_id"], name: "index_parts_on_video_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "name",        null: false
    t.string   "guid",        null: false
    t.string   "artist_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["guid"], name: "index_songs_on_guid", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
