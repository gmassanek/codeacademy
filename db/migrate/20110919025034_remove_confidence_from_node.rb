class RemoveConfidenceFromNode < ActiveRecord::Migration
  def self.up
    remove_column :nodes, :confidence
  end

  def self.down
    add_column :nodes, :confidence, :int
  end
end
