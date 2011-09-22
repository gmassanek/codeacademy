class AddUserInfoToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :created_by_id, :integer
    add_column :nodes, :last_updated_by_id, :integer
  end

  def self.down
    remove_column :nodes, :last_updated_by_id
    remove_column :nodes, :created_by_id
  end
end
