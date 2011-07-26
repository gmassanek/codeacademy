class AddStackOverflowToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :stack_search_key, :string
  end

  def self.down
    remove_column :nodes, :stack_search_key
  end
end
