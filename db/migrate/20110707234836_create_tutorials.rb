class CreateTutorials < ActiveRecord::Migration
  def self.up
    create_table :tutorials do |t|
      t.integer :node_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :tutorials
  end
end
