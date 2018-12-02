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

ActiveRecord::Schema.define(version: 2018_12_01_154433) do

  create_table "manual_rates", force: :cascade do |t|
    t.float "rate"
    t.datetime "die_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string "currency_pair"
    t.string "state"
    t.string "current_rate_type"
    t.integer "current_rate_id"
    t.integer "real_rate_id"
    t.integer "manual_rate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_rate_type", "current_rate_id"], name: "index_quotes_on_current_rate_type_and_current_rate_id"
    t.index ["manual_rate_id"], name: "index_quotes_on_manual_rate_id"
    t.index ["real_rate_id"], name: "index_quotes_on_real_rate_id"
  end

  create_table "real_rates", force: :cascade do |t|
    t.float "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
