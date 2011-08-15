class PolymorphiseLinks < ActiveRecord::Migration
  def self.up
    site_handles = SiteHandle.all.collect do |h| [h.id, h.node_id] end
    puts site_handles.inspect

    add_column :links, :linkable_type, :string
    add_column :links, :linkable_id, :integer
    remove_column :links, :node_id
    remove_column :links, :relationship_id

    SiteHandle.reset_column_information 
    
    site_handles.all.each do |h| 
      handle = SiteHandle.find_by_id(h.id)
      handle.item_type = 'Node'
      handle.item_id = h.node_id
      handle.save
    ena
  end

  def self.down
    remove_column :links, :linkable_type
    remove_column :links, :linkable_id
    add_column :links, :node_id, :integer
    add_column :links, :relationship_id, :integer
  end
end
