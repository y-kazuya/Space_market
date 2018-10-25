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

ActiveRecord::Schema.define(version: 20181024074836) do

  create_table "amenities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "basic_info_usages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "basic_info_id", null: false
    t.integer  "usage_id",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["basic_info_id", "usage_id"], name: "index_basic_info_usages_on_basic_info_id_and_usage_id", using: :btree
    t.index ["basic_info_id"], name: "index_basic_info_usages_on_basic_info_id", using: :btree
    t.index ["usage_id"], name: "index_basic_info_usages_on_usage_id", using: :btree
  end

  create_table "basic_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "capacity",       null: false
    t.integer  "floor_space",    null: false
    t.integer  "key_type",       null: false
    t.integer  "reserve_limit",  null: false
    t.integer  "reserve_period", null: false
    t.integer  "room_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["room_id"], name: "index_basic_infos_on_room_id", using: :btree
  end

  create_table "intros", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                    null: false
    t.text     "content",    limit: 65535, null: false
    t.text     "service",    limit: 65535, null: false
    t.integer  "room_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["room_id"], name: "index_intros_on_room_id", using: :btree
  end

  create_table "pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",                  null: false
    t.text     "about",      limit: 65535
    t.integer  "cover",                    null: false
    t.integer  "room_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["room_id"], name: "index_pictures_on_room_id", using: :btree
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                        null: false
    t.text     "about",         limit: 65535
    t.boolean  "day_pay",                     null: false
    t.integer  "day_price"
    t.boolean  "time_pay",                    null: false
    t.integer  "time_price"
    t.boolean  "about_reserve",               null: false
    t.integer  "room_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["room_id"], name: "index_plans_on_room_id", using: :btree
  end

  create_table "room_amenities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "amenity_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_room_amenities_on_amenity_id", using: :btree
    t.index ["room_id"], name: "index_room_amenities_on_room_id", using: :btree
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "activated",  default: false
    t.integer  "space_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["space_id"], name: "index_rooms_on_space_id", using: :btree
  end

  create_table "space_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_code",                  null: false
    t.integer  "state",                      null: false
    t.string   "city",                       null: false
    t.string   "address",                    null: false
    t.string   "last_address"
    t.string   "map_address",                null: false
    t.text     "access",       limit: 65535, null: false
    t.integer  "phone_number",               null: false
    t.integer  "event_type",                 null: false
    t.integer  "user_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["state"], name: "index_space_infos_on_state", using: :btree
    t.index ["user_id"], name: "index_space_infos_on_user_id", using: :btree
  end

  create_table "spaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "space_info_id"
    t.index ["space_info_id"], name: "index_spaces_on_space_info_id", using: :btree
    t.index ["user_id"], name: "index_spaces_on_user_id", using: :btree
  end

  create_table "tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "last_name",                                            null: false
    t.string   "first_name",                                           null: false
    t.string   "email",                                                null: false
    t.string   "encrypted_password",                                   null: false
    t.string   "company"
    t.string   "avatar"
    t.text     "profile",                limit: 65535
    t.string   "URL"
    t.integer  "timezone"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.boolean  "admin",                                default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weeks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.integer  "start_time", null: false
    t.integer  "end_time",   null: false
    t.integer  "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "can"
    t.index ["name", "plan_id"], name: "index_weeks_on_name_and_plan_id", unique: true, using: :btree
    t.index ["plan_id"], name: "index_weeks_on_plan_id", using: :btree
  end

  add_foreign_key "basic_info_usages", "basic_infos"
  add_foreign_key "basic_info_usages", "usages"
  add_foreign_key "basic_infos", "rooms"
  add_foreign_key "intros", "rooms"
  add_foreign_key "pictures", "rooms"
  add_foreign_key "plans", "rooms"
  add_foreign_key "room_amenities", "amenities"
  add_foreign_key "room_amenities", "rooms"
  add_foreign_key "rooms", "spaces"
  add_foreign_key "space_infos", "users"
  add_foreign_key "weeks", "plans"
end
