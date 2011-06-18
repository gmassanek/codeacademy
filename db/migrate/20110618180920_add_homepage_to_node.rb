class AddHomepageToNode < ActiveRecord::Migration
  def self.up
    add_column :nodes, :homepage, :string
  end

  def self.down
    remove_column :nodes, :homepage
  end
end
