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

ActiveRecord::Schema.define(:version => 20110809232358) do

  create_table "links", :force => true do |t|
    t.string  "url"
    t.integer "element_id"
    t.string  "element_type"
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
    t.boolean  "learned"
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
    t.integer "node_id"
    t.string  "twitter"
    t.string  "github"
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
    t.integer  "node_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
