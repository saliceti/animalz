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

ActiveRecord::Schema.define(version: 2019_08_02_060041) do

  create_table "animal_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "animal_families", force: :cascade do |t|
    t.string "name"
    t.integer "animal_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_order_id"], name: "index_animal_families_on_animal_order_id"
  end

  create_table "animal_genus", force: :cascade do |t|
    t.string "name"
    t.integer "animal_families_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_families_id"], name: "index_animal_genus_on_animal_families_id"
  end

  create_table "animal_orders", force: :cascade do |t|
    t.string "name"
    t.integer "animal_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_class_id"], name: "index_animal_orders_on_animal_class_id"
  end

  create_table "animal_species", force: :cascade do |t|
    t.string "name"
    t.integer "animal_genus_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_genus_id"], name: "index_animal_species_on_animal_genus_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "family_id"
    t.index ["family_id"], name: "index_animals_on_family_id"
  end

  create_table "class_records", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "phylum_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phylum_record_id"], name: "index_class_records_on_phylum_record_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_records", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "order_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_record_id"], name: "index_family_records_on_order_record_id"
  end

  create_table "genus_records", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "family_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_record_id"], name: "index_genus_records_on_family_record_id"
  end

  create_table "order_records", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "class_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_record_id"], name: "index_order_records_on_class_record_id"
  end

  create_table "phylum_records", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species_records", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "genus_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genus_record_id"], name: "index_species_records_on_genus_record_id"
  end

end
