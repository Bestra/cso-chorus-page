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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130929180109) do

  create_table "chair_schedules", :force => true do |t|
    t.integer  "member_id"
    t.datetime "schedule_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "email_addresses", :force => true do |t|
    t.integer  "member_id"
    t.string   "address"
    t.boolean  "publish"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "folders", :force => true do |t|
    t.integer  "member_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_statuses", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "program_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.boolean  "publish_data"
    t.integer  "height"
    t.date     "date_joined"
    t.integer  "voice_part_id"
    t.string   "photo_path"
    t.integer  "status_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "old_id"
    t.boolean  "picture"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "no_chairs"
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer  "member_id"
    t.string   "number"
    t.integer  "phone_type_id"
    t.boolean  "publish"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "phone_types", :force => true do |t|
    t.string   "description"
    t.string   "abbreviation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "voice_parts", :force => true do |t|
    t.string   "description"
    t.string   "part"
    t.string   "abbreviation"
    t.integer  "section"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
