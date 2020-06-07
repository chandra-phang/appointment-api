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

ActiveRecord::Schema.define(version: 2020_06_02_144610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.integer "patient_id", null: false
    t.integer "hospital_id", null: false
    t.string "start_at"
    t.string "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id", "doctor_id", "patient_id"], name: "index_appointments_on_hospital_id_and_doctor_id_and_patient_id", unique: true
  end

  create_table "doctor_schedules", force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.integer "hospital_id", null: false
    t.integer "day_of_week", array: true
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id", "doctor_id"], name: "index_doctor_schedules_on_hospital_id_and_doctor_id", unique: true
  end

  create_table "hospital_affiliations", force: :cascade do |t|
    t.integer "hospital_id", null: false
    t.integer "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id", "doctor_id"], name: "index_hospital_affiliations_on_hospital_id_and_doctor_id", unique: true
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name", null: false
    t.string "state"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_hospitals_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "role"
    t.string "state"
    t.string "gender"
    t.date "date_of_birth"
    t.string "encrypted_password", default: "", null: false
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "appointments", "hospitals"
  add_foreign_key "appointments", "users", column: "doctor_id"
  add_foreign_key "appointments", "users", column: "patient_id"
  add_foreign_key "doctor_schedules", "hospitals"
  add_foreign_key "doctor_schedules", "users", column: "doctor_id"
  add_foreign_key "hospital_affiliations", "hospitals"
  add_foreign_key "hospital_affiliations", "users", column: "doctor_id"
end
