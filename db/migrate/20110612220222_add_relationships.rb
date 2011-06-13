class AddRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :node1_id
      t.integer :node2_id
      t.string :sentence1
      t.string :sentence2
      t.timestamps
    end

    add_index("relationships", "node1_id")
    add_index("relationships", "node2_id")
    #add_foreign_key(:relationships, :node1_id, :nodes)
    #add_foreing_key(:relationships, :node2_id, :nodes)
  end

  def self.down
    drop_table :relationships
  end
end
