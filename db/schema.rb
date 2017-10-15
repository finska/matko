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

ActiveRecord::Schema.define(version: 20171015220622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banners", force: :cascade do |t|
    t.bigint "company_id"
    t.string "image"
    t.string "link"
    t.boolean "status"
    t.datetime "active_from"
    t.datetime "active_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_banners_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "host"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.text "address"
  end

  create_table "shipment_codes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "provider_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "additional_shipment_info"
    t.integer "company_id"
    t.string "link"
    t.index ["provider_id"], name: "index_shipment_codes_on_provider_id"
    t.index ["user_id"], name: "index_shipment_codes_on_user_id"
  end

  create_table "shipment_events", force: :cascade do |t|
    t.bigint "shipment_code_id"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "provider"
    t.datetime "query"
    t.text "details"
    t.text "label"
    t.index ["shipment_code_id"], name: "index_shipment_events_on_shipment_code_id"
  end

  create_table "user_families", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email"
    t.integer "shipment_code_id"
    t.index ["user_id"], name: "index_user_families_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "banners", "companies"
  add_foreign_key "shipment_codes", "providers"
  add_foreign_key "shipment_codes", "users"
  add_foreign_key "shipment_events", "shipment_codes"
  add_foreign_key "user_families", "users"
end
