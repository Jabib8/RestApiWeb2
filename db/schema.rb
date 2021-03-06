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

ActiveRecord::Schema.define(version: 20160427162043) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "active"
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "url_img",     limit: 255
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "transfers", force: :cascade do |t|
    t.integer  "product_req_id",     limit: 4
    t.integer  "product_offer_id",   limit: 4
    t.boolean  "active"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "state",              limit: 255
    t.integer  "user_id",            limit: 4
    t.string   "product_req_name",   limit: 255
    t.string   "product_offer_name", limit: 255
    t.string   "to_whom",            limit: 255
  end

  add_index "transfers", ["product_offer_id"], name: "fk_rails_8d607ad088", using: :btree
  add_index "transfers", ["product_req_id"], name: "fk_rails_e001a2452a", using: :btree
  add_index "transfers", ["user_id"], name: "fk_rails_344b52b7fd", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "firstname",       limit: 255
    t.string   "token",           limit: 255
    t.datetime "valid_up"
    t.boolean  "active"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "email",           limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "products", "users"
  add_foreign_key "transfers", "products", column: "product_offer_id"
  add_foreign_key "transfers", "products", column: "product_req_id"
  add_foreign_key "transfers", "users"
end
