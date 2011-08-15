class PolymorphiseSiteHandles < ActiveRecord::Migration
  def self.up
    add_column :site_handles, :item_type, :string
    add_column :site_handles, :item_id, :integer
    remove_column :site_handles, :node_id
  end

  def self.down
    remove_column :site_handles, :item_type
    remove_column :site_handles, :item_id
    add_column :site_handles, :node_id, :integer
  end
end
