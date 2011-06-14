class AddKeyToRelationships < ActiveRecord::Migration
  def self.up
    add_column :relationships, :key, :string
  end

  def self.down
    remove_column :relationships, :key
  end
end
