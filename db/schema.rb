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

ActiveRecord::Schema.define(version: 20151027234806) do

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.boolean  "buyInWholeUnits", default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "properties", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.boolean  "vegitarian",    default: false
    t.boolean  "vegan",         default: false
    t.boolean  "lactoseFree",   default: true
    t.boolean  "glutenFree",    default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "properties", ["ingredient_id"], name: "index_properties_on_ingredient_id"
  add_index "properties", ["recipe_id"], name: "index_properties_on_recipe_id"

  create_table "quantities", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "listName"
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "quantities", ["ingredient_id"], name: "index_quantities_on_ingredient_id"
  add_index "quantities", ["recipe_id"], name: "index_quantities_on_recipe_id"
  add_index "quantities", ["user_id"], name: "index_quantities_on_user_id"

  create_table "queued_recipes", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "instructions"
    t.integer  "author_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "recipes", ["author_id"], name: "index_recipes_on_author_id"

  create_table "recipes_users", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
