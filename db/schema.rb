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

ActiveRecord::Schema.define(version: 20181112005246) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "space_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_admins_on_space_id", using: :btree
    t.index ["user_id", "space_id"], name: "index_admins_on_user_id_and_space_id", using: :btree
    t.index ["user_id"], name: "index_admins_on_user_id", using: :btree
  end

  create_table "agreements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "aggree",     limit: 65535
    t.text     "policy",     limit: 65535
    t.integer  "room_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["room_id"], name: "index_agreements_on_room_id", using: :btree
  end

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

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "num_first",   null: false
    t.string   "num_seconde", null: false
    t.string   "num_thard",   null: false
    t.string   "num_last",    null: false
    t.string   "name",        null: false
    t.integer  "mm",          null: false
    t.integer  "yy",          null: false
    t.string   "code",        null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "use"
    t.index ["user_id"], name: "index_cards_on_user_id", using: :btree
  end

  create_table "company_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "post_code",         null: false
    t.integer  "state",             null: false
    t.string   "city",              null: false
    t.string   "city_kata",         null: false
    t.string   "address",           null: false
    t.string   "address_kata",      null: false
    t.string   "last_address",      null: false
    t.string   "last_address_kata", null: false
    t.string   "building"
    t.string   "building_kata"
    t.integer  "host_profile_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["host_profile_id"], name: "index_company_addresses_on_host_profile_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name",                   null: false
    t.string   "last_name",                    null: false
    t.string   "phone_number",                 null: false
    t.boolean  "company",      default: false, null: false
    t.string   "company_name"
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_contacts_on_user_id", using: :btree
  end

  create_table "favorite_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_favorite_lists_on_name_and_user_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_favorite_lists_on_user_id", using: :btree
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "room_id",          null: false
    t.integer  "favorite_list_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["favorite_list_id", "room_id"], name: "index_favorites_on_favorite_list_id_and_room_id", unique: true, using: :btree
    t.index ["favorite_list_id"], name: "index_favorites_on_favorite_list_id", using: :btree
    t.index ["room_id"], name: "index_favorites_on_room_id", using: :btree
  end

  create_table "host_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "post_code",         null: false
    t.integer  "state",             null: false
    t.string   "city",              null: false
    t.string   "city_kata",         null: false
    t.string   "address",           null: false
    t.string   "address_kata",      null: false
    t.string   "last_address",      null: false
    t.string   "last_address_kata", null: false
    t.string   "building"
    t.string   "building_kata"
    t.integer  "host_profile_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["host_profile_id"], name: "index_host_addresses_on_host_profile_id", using: :btree
  end

  create_table "host_banks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "bank_name",       null: false
    t.string   "bank_code",       null: false
    t.string   "branch_name",     null: false
    t.string   "branch_code",     null: false
    t.string   "account_number",  null: false
    t.string   "account_name",    null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "host_profile_id"
    t.index ["host_profile_id"], name: "index_host_banks_on_host_profile_id", using: :btree
  end

  create_table "host_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "about_mail_1",    default: true
    t.boolean  "about_mail_2",    default: true
    t.boolean  "about_mail_3",    default: true
    t.boolean  "about_mail_4",    default: true
    t.boolean  "about_mail_5",    default: true
    t.boolean  "about_mail_6",    default: true
    t.boolean  "about_call_1",    default: true
    t.boolean  "about_call_2",    default: true
    t.boolean  "about_call_3",    default: true
    t.integer  "host_profile_id",                null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["host_profile_id"], name: "index_host_notifications_on_host_profile_id", using: :btree
  end

  create_table "host_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "last_name",                                       null: false
    t.string   "first_name",                                      null: false
    t.string   "last_name_kata",                                  null: false
    t.string   "first_name_kata",                                 null: false
    t.integer  "sex",                             default: 0,     null: false
    t.integer  "born_year",                                       null: false
    t.integer  "born_manth",                                      null: false
    t.integer  "born_day",                                        null: false
    t.string   "avatar",                                          null: false
    t.integer  "phone_number",                                    null: false
    t.string   "identification",                                  null: false
    t.boolean  "company",                         default: false, null: false
    t.string   "company_name"
    t.string   "company_name_kata"
    t.string   "company_name_en"
    t.string   "company_number"
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "profile",           limit: 65535
    t.index ["user_id", "id"], name: "index_host_profiles_on_user_id_and_id", using: :btree
    t.index ["user_id"], name: "index_host_profiles_on_user_id", using: :btree
  end

  create_table "intend_points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "point",      null: false
    t.string   "date",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_intend_points_on_user_id", using: :btree
  end

  create_table "intros", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                    null: false
    t.text     "content",    limit: 65535, null: false
    t.text     "service",    limit: 65535, null: false
    t.integer  "room_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "food",       limit: 65535
    t.text     "clean",      limit: 65535
    t.string   "pdf"
    t.index ["room_id"], name: "index_intros_on_room_id", using: :btree
  end

  create_table "option_pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",                  null: false
    t.text     "about",      limit: 65535
    t.integer  "cover",                    null: false
    t.integer  "option_id",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["option_id"], name: "index_option_pictures_on_option_id", using: :btree
  end

  create_table "options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                    null: false
    t.text     "about",      limit: 65535
    t.integer  "price",                                   null: false
    t.integer  "unit",                                    null: false
    t.integer  "amount"
    t.boolean  "public",                   default: true
    t.integer  "room_id",                                 null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["room_id"], name: "index_options_on_room_id", using: :btree
  end

  create_table "pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",                  null: false
    t.text     "about",      limit: 65535
    t.integer  "cover",                    null: false
    t.integer  "room_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "movie"
    t.index ["room_id"], name: "index_pictures_on_room_id", using: :btree
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                       null: false
    t.text     "about",         limit: 65535
    t.boolean  "day_pay",                                    null: false
    t.integer  "day_price"
    t.boolean  "time_pay",                    default: true, null: false
    t.integer  "time_price"
    t.boolean  "about_reserve",               default: true, null: false
    t.integer  "room_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "min_time"
    t.integer  "clean_time"
    t.integer  "discount",                    default: 0
    t.integer  "cost"
    t.string   "start_day"
    t.string   "end_day"
    t.boolean  "public",                      default: true
    t.index ["room_id"], name: "index_plans_on_room_id", using: :btree
  end

  create_table "reserve_dates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "start_date",                 null: false
    t.boolean  "day",        default: false, null: false
    t.integer  "reserve_id",                 null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "start_time"
    t.string   "end_time"
    t.index ["reserve_id"], name: "index_reserve_dates_on_reserve_id", using: :btree
  end

  create_table "reserve_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "reserve_id",             null: false
    t.integer  "option_id",              null: false
    t.integer  "amount",     default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["option_id"], name: "index_reserve_options_on_option_id", using: :btree
    t.index ["reserve_id"], name: "index_reserve_options_on_reserve_id", using: :btree
  end

  create_table "reserve_phrases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "success",    limit: 65535
    t.text     "fail",       limit: 65535
    t.text     "remind",     limit: 65535
    t.integer  "room_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["room_id"], name: "index_reserve_phrases_on_room_id", using: :btree
  end

  create_table "reserves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "company",                                  null: false
    t.integer  "payment",                                  null: false
    t.integer  "purpose",                                  null: false
    t.integer  "people",                                   null: false
    t.text     "usage",      limit: 65535
    t.boolean  "coupon",                   default: false, null: false
    t.integer  "price"
    t.integer  "user_id",                                  null: false
    t.integer  "plan_id",                                  null: false
    t.integer  "room_id",                                  null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "day"
    t.boolean  "activated",                default: false
    t.integer  "card_id"
    t.index ["card_id"], name: "index_reserves_on_card_id", using: :btree
    t.index ["plan_id"], name: "index_reserves_on_plan_id", using: :btree
    t.index ["room_id"], name: "index_reserves_on_room_id", using: :btree
    t.index ["user_id", "created_at"], name: "index_reserves_on_user_id_and_created_at", unique: true, using: :btree
    t.index ["user_id"], name: "index_reserves_on_user_id", using: :btree
  end

  create_table "room_amenities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "amenity_id", null: false
    t.integer  "room_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_room_amenities_on_amenity_id", using: :btree
    t.index ["room_id"], name: "index_room_amenities_on_room_id", using: :btree
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "activated",  default: 0,    null: false
    t.integer  "space_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "public",     default: true
    t.index ["space_id"], name: "index_rooms_on_space_id", using: :btree
  end

  create_table "space_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "post_code",                  null: false
    t.integer  "state",                      null: false
    t.string   "city",                       null: false
    t.string   "address",                    null: false
    t.string   "last_address"
    t.string   "map_address",                null: false
    t.text     "access",       limit: 65535, null: false
    t.string   "phone_number",               null: false
    t.integer  "event_type",                 null: false
    t.integer  "user_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "fax"
    t.string   "url"
    t.string   "title"
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

  create_table "user_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "about_mail_1", default: true
    t.boolean  "about_mail_2", default: true
    t.boolean  "about_mail_3", default: true
    t.boolean  "about_mail_4", default: true
    t.boolean  "about_mail_5", default: true
    t.boolean  "about_call_1", default: true
    t.boolean  "about_call_2", default: true
    t.boolean  "about_call_3", default: true
    t.integer  "user_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "about_call_4", default: true
    t.index ["user_id"], name: "index_user_notifications_on_user_id", using: :btree
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
    t.boolean  "owner",                                default: false
    t.integer  "point",                                default: 1000
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weeks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                      null: false
    t.integer  "start_time",                null: false
    t.integer  "end_time",                  null: false
    t.integer  "plan_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "can",        default: true
    t.index ["name", "plan_id"], name: "index_weeks_on_name_and_plan_id", unique: true, using: :btree
    t.index ["plan_id"], name: "index_weeks_on_plan_id", using: :btree
  end

  add_foreign_key "admins", "spaces"
  add_foreign_key "admins", "users"
  add_foreign_key "agreements", "rooms"
  add_foreign_key "basic_info_usages", "basic_infos"
  add_foreign_key "basic_info_usages", "usages"
  add_foreign_key "basic_infos", "rooms"
  add_foreign_key "cards", "users"
  add_foreign_key "company_addresses", "host_profiles"
  add_foreign_key "contacts", "users"
  add_foreign_key "favorite_lists", "users"
  add_foreign_key "favorites", "favorite_lists"
  add_foreign_key "favorites", "rooms"
  add_foreign_key "host_addresses", "host_profiles"
  add_foreign_key "host_banks", "host_profiles"
  add_foreign_key "host_notifications", "host_profiles"
  add_foreign_key "host_profiles", "users"
  add_foreign_key "intend_points", "users"
  add_foreign_key "intros", "rooms"
  add_foreign_key "option_pictures", "options"
  add_foreign_key "options", "rooms"
  add_foreign_key "pictures", "rooms"
  add_foreign_key "plans", "rooms"
  add_foreign_key "reserve_dates", "reserves", column: "reserve_id"
  add_foreign_key "reserve_options", "options"
  add_foreign_key "reserve_options", "reserves", column: "reserve_id"
  add_foreign_key "reserve_phrases", "rooms"
  add_foreign_key "reserves", "plans"
  add_foreign_key "reserves", "rooms"
  add_foreign_key "reserves", "users"
  add_foreign_key "room_amenities", "amenities"
  add_foreign_key "room_amenities", "rooms"
  add_foreign_key "rooms", "spaces"
  add_foreign_key "space_infos", "users"
  add_foreign_key "user_notifications", "users"
  add_foreign_key "weeks", "plans"
end
