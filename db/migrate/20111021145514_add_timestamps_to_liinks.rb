class AddTimestampsToLiinks < ActiveRecord::Migration
  def self.up
    add_column :links, :created_at, :time
    add_column :links, :updated_at, :time
  end

  def self.down
    remove_column :links, :created_at
    remove_column :links, :updated_at
  end
end
