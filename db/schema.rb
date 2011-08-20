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

ActiveRecord::Schema.define(:version => 20110803195209) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_submissions", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "submission_id"
  end

  create_table "commits", :force => true do |t|
    t.string   "message"
    t.text     "files"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hackers", :force => true do |t|
    t.string   "email",               :null => false
    t.string   "name"
    t.string   "crypted_password",    :null => false
    t.string   "password_salt",       :null => false
    t.string   "persistence_token",   :null => false
    t.string   "perishable_token",    :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_id"
    t.text     "description"
    t.boolean  "admin"
    t.string   "single_access_token"
    t.text     "requirments"
  end

  create_table "hackers_teams", :id => false, :force => true do |t|
    t.integer "hacker_id"
    t.integer "team_id"
  end

  create_table "ircs", :force => true do |t|
    t.string   "by"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.integer  "hacker_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "created_by"
  end

  create_table "tweets", :force => true do |t|
    t.string   "username"
    t.string   "body"
    t.string   "avatar_url"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "tweeted_at"
  end

end
