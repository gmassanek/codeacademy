class AddTwitterSearchKeyToNode < ActiveRecord::Migration
  def self.up
    add_column :nodes, :twitter_search_key, :string
  end

  def self.down
    remove_column :nodes, :twitter_search_key
  end
end
