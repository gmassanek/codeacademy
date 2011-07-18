class AddConfidenceToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :confidence, :int
  end

  def self.down
    remove_column :nodes, :confidence
  end
end
