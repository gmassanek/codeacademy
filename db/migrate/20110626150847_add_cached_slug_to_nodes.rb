class AddCachedSlugToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :cached_slug, :string
  end

  def self.down
    remove_column :nodes, :cached_slug
  end
end
