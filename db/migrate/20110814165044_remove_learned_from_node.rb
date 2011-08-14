class RemoveLearnedFromNode < ActiveRecord::Migration
  def self.up
    remove_column :nodes, :learned
  end

  def self.down
    add_column :nodes, :learned, :boolean
  end
end
