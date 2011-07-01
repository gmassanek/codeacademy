class AddLearnedToNode < ActiveRecord::Migration
  def self.up
    add_column :nodes, :learned, :boolean
  end

  def self.down
    remove_column :nodes, :learned
  end
end
