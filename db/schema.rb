ActiveRecord::Schema.define(version: 2020_04_19_175857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trades", force: :cascade do |t|
    t.string "ticker", null: false
    t.float "entry"
    t.integer "shares"
    t.float "stop"
    t.string "setup", null: false
    t.string "date"
    t.float "profit", null: false
    t.integer "trade_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "open"
    t.string "high"
    t.string "low"
    t.string "close"
    t.string "vol"
    t.string "prevClose"
    t.integer "volAvg"
    t.float "mktCap"
    t.string "company"
    t.string "industry"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "nickname"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
