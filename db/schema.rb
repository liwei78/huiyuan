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

ActiveRecord::Schema.define(:version => 20120902164813) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "publish",      :default => false
    t.string   "title"
    t.text     "content"
    t.string   "download_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "videocode"
  end

  create_table "photos", :force => true do |t|
    t.integer  "message_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ori_message_id"
    t.boolean  "read",           :default => false
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "videocode"
  end

  add_index "user_messages", ["user_id"], :name => "index_user_messages_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "salt"
    t.string   "encrypted_password"
    t.string   "signcode"
    t.string   "verifycode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "online",             :default => false
    t.datetime "last_login"
  end

end
