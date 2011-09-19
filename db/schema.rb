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

ActiveRecord::Schema.define(:version => 20110917062232) do

  create_table "links", :force => true do |t|
    t.string  "url"
    t.string  "linkable_type"
    t.integer "linkable_id"
  end

  create_table "nodes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "homepage"
    t.string   "cached_slug"
    t.string   "twitter_search_key"
    t.integer  "confidence"
    t.string   "stack_search_key"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "node1_id"
    t.integer  "node2_id"
    t.string   "sentence1"
    t.string   "sentence2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  add_index "relationships", ["node1_id"], :name => "index_relationships_on_node1_id"
  add_index "relationships", ["node2_id"], :name => "index_relationships_on_node2_id"

  create_table "site_handles", :force => true do |t|
    t.string  "twitter"
    t.string  "github"
    t.string  "item_type"
    t.integer "item_id"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tutorials", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_helpfulness_ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "helpfulness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_knowledge_ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "knowledgeable_id"
    t.string   "knowledgeable_type"
    t.integer  "knowledge_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
