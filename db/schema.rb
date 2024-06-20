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

ActiveRecord::Schema[7.1].define(version: 2024_05_25_230326) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "account_number"
    t.string "account_type"
    t.decimal "balance"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["client_id"], name: "index_bank_accounts_on_client_id"
    t.index ["deleted_at"], name: "index_bank_accounts_on_deleted_at"
  end

  create_table "bills", force: :cascade do |t|
    t.decimal "amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "password_reset_token"
    t.datetime "password_reset_token_sent_at"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["password_reset_token"], name: "index_clients_on_password_reset_token"
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "transaction_type"
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bank_account_id", null: false
    t.index ["bank_account_id"], name: "index_transactions_on_bank_account_id"
    t.index ["recipient_id"], name: "index_transactions_on_recipient_id"
    t.index ["sender_id"], name: "index_transactions_on_sender_id"
  end

  add_foreign_key "bank_accounts", "clients"
  add_foreign_key "transactions", "bank_accounts"
  add_foreign_key "transactions", "bank_accounts", column: "recipient_id"
  add_foreign_key "transactions", "bank_accounts", column: "sender_id"
end
