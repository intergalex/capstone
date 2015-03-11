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

ActiveRecord::Schema.define(version: 20150311021116) do

  create_table "doers", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "email",      limit: 255
    t.datetime "join"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "happening_doers", force: :cascade do |t|
    t.integer  "happening_id", limit: 4
    t.integer  "doer_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "happenings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",         limit: 255
    t.datetime "datetime"
    t.string   "info",         limit: 255
    t.integer  "submitted_by", limit: 4
    t.string   "address",      limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "zipcode",      limit: 255
  end

end