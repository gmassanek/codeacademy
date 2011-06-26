class AddRelationshipToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :relationship_id, :integer
  end

  def self.down
    remove_column :links, :relationship_id
  end
end
