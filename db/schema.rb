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

ActiveRecord::Schema.define(version: 20_191_108_100_616) do
  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.text "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "price"
    t.string "currency"
    t.string "status"
    t.integer "reservation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_payments_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "quantity"
    t.boolean "is_paid", default: false, null: false
    t.integer "ticket_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_reservations_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "quantity"
    t.string "ticket_type"
    t.decimal "price"
    t.string "currency"
    t.integer "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  add_foreign_key "payments", "reservations"
  add_foreign_key "reservations", "tickets"
  add_foreign_key "tickets", "events"
end
