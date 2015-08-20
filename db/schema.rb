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

ActiveRecord::Schema.define(version: 20150820110932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "contact_info",   null: false
    t.string   "job_status",     null: false
    t.integer  "desired_salary", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "title", null: false
  end

  add_index "skills", ["title"], name: "index_skills_on_title", unique: true, using: :btree

  create_table "specified_skills", force: :cascade do |t|
    t.integer "owner_id",   null: false
    t.string  "owner_type", null: false
    t.integer "skill_id",   null: false
  end

  add_index "specified_skills", ["owner_id", "owner_type"], name: "index_specified_skills_on_owner_id_and_owner_type", using: :btree
  add_index "specified_skills", ["skill_id"], name: "index_specified_skills_on_skill_id", using: :btree

  create_table "vacancies", force: :cascade do |t|
    t.string    "title",           null: false
    t.date      "expiration_date", null: false
    t.int4range "salary",          null: false
    t.text      "contact_info",    null: false
    t.datetime  "created_at",      null: false
    t.datetime  "updated_at",      null: false
  end

  add_foreign_key "specified_skills", "skills"
end
