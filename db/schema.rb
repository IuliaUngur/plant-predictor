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

ActiveRecord::Schema.define(version: 20161112171555) do

  create_table "readings", force: :cascade do |t|
    t.decimal  "value"
    t.integer  "sensor_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["sensor_id"], name: "index_readings_on_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.decimal  "average_value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "version_set_id"
    t.index ["version_set_id"], name: "index_sensors_on_version_set_id"
  end

  create_table "version_sets", force: :cascade do |t|
    t.string   "subject"
    t.string   "image"
    t.boolean  "prediction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
