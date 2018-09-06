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

ActiveRecord::Schema.define(version: 20180904083934) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.string   "zip_code_1", null: false
    t.string   "zip_code_2", null: false
    t.string   "state",      null: false
    t.string   "address_1",  null: false
    t.string   "address_2",  null: false
    t.string   "tel",        null: false
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.index ["order_id"], name: "index_addresses_on_order_id", using: :btree
    t.index ["owner_id"], name: "index_addresses_on_owner_id", using: :btree
  end

  create_table "captured_image_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.integer  "order"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_captured_image_courses_on_course_id", using: :btree
  end

  create_table "captured_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",    null: false
    t.integer  "status",     null: false
    t.integer  "order",      null: false
    t.integer  "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_captured_images_on_plan_id", using: :btree
  end

  create_table "course_descriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535, null: false
    t.integer  "course_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["course_id"], name: "index_course_descriptions_on_course_id", using: :btree
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "price"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "plan_id"
    t.text     "card_desc_summary", limit: 65535
    t.index ["plan_id"], name: "index_courses_on_plan_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "owner_id"
    t.string   "course_id_list"
    t.string   "course_count_list"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "sum",                             default: 0, null: false
    t.text     "description",       limit: 65535
    t.integer  "address_id"
    t.index ["address_id"], name: "index_orders_on_address_id", using: :btree
    t.index ["owner_id"], name: "index_orders_on_owner_id", using: :btree
  end

  create_table "owners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "last_name",                            default: "", null: false
    t.string   "first_name",                           default: "", null: false
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.text     "image",                  limit: 65535
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "admin"
    t.index ["email"], name: "index_owners_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true, using: :btree
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "title",              limit: 65535, null: false
    t.string   "shop_name",                        null: false
    t.string   "place",                            null: false
    t.text     "contents",           limit: 65535
    t.string   "registration_fee",                 null: false
    t.string   "closing_date_month",               null: false
    t.string   "closing_date_day",                 null: false
    t.text     "plan_detail",        limit: 65535
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
