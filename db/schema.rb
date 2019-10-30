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

ActiveRecord::Schema.define(version: 2019_10_29_035455) do

  create_table "discount_rules", force: :cascade do |t|
    t.string "name"
    t.integer "target_type"
    t.integer "discount_type"
    t.float "discount"
    t.float "bonus_after_reaching"
    t.float "charge_per_square_foot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "range_type_discount_rules", force: :cascade do |t|
    t.integer "items_number_from"
    t.integer "items_number_to"
    t.float "discount"
    t.integer "discount_rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_rule_id"], name: "index_range_type_discount_rules_on_discount_rule_id"
  end

end
