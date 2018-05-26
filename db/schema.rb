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

ActiveRecord::Schema.define(version: 2018_05_26_215013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_orders", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "order_id"
    t.index ["item_id"], name: "index_item_orders_on_item_id"
    t.index ["order_id"], name: "index_item_orders_on_order_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "image"
    t.text "description"
    t.boolean "is_retired?"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.integer "quantity"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.datetime "installation_date"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "end_station_id"
    t.bigint "start_station_id"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
    t.index ["end_station_id"], name: "index_trips_on_end_station_id"
    t.index ["start_station_id"], name: "index_trips_on_start_station_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name"
    t.string "address"
    t.string "username"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "item_orders", "items"
  add_foreign_key "item_orders", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "trips", "stations", column: "end_station_id"
  add_foreign_key "trips", "stations", column: "start_station_id"
end
