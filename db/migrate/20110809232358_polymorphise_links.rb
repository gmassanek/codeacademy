class PolymorphiseLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :linkable_type, :string
    add_column :links, :linkable_id, :integer
    remove_column :links, :node_id
    remove_column :links, :relationship_id
  end

  def self.down
    remove_column :links, :linkable_type
    remove_column :links, :linkable_id
    add_column :links, :node_id, :integer
    add_column :links, :relationship_id, :integer
  end
end
