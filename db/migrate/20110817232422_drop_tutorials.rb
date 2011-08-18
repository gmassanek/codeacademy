class DropTutorials < ActiveRecord::Migration
  def self.up
    drop_table :tutorials
  end

  def self.down
    create_table :tutorials do |t|
      t.integer :node_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
