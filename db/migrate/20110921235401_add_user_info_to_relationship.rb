class AddUserInfoToRelationship < ActiveRecord::Migration
  def self.up
    add_column :relationships, :created_by_id, :integer
    add_column :relationships, :last_updated_by_id, :integer
  end

  def self.down
    remove_column :relationships, :last_updated_by_id
    remove_column :relationships, :created_by_id
  end
end
