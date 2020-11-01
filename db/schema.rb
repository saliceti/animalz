# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_01_191303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "taxons", force: :cascade do |t|
    t.string "rank"
    t.string "common_name"
    t.string "scientific_name"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_taxons_on_parent_id"
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.string "link"
    t.bigint "taxon_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "youtube_id"
    t.index ["taxon_id"], name: "index_youtube_videos_on_taxon_id"
  end

  add_foreign_key "youtube_videos", "taxons"
end
