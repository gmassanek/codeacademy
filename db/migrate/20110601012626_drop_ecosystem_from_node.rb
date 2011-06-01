class DropEcosystemFromNode < ActiveRecord::Migration
  def self.up
    remove_column :nodes, :ecosystem
  end

  def self.down
    add_column :nodes, :ecosystem, :string
  end
end
