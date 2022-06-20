# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_19_054706) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.bigint "isbn", null: false
    t.string "title", null: false
    t.string "author", null: false
    t.string "category"
    t.integer "price"
    t.integer "fine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "quantity", default: 1
    t.boolean "is_active", default: true
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.date "order_date", null: false
    t.date "due_date", null: false
    t.date "return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token"
    t.bigint "wallet", default: 10000, null: false
    t.string "password_digest", null: false
    t.boolean "is_admin", default: false
    t.boolean "is_active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
