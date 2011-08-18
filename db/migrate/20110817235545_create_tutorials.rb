class CreateTutorials < ActiveRecord::Migration
  def self.up
    create_table :tutorials do |t|
      t.integer :item_id
      t.string :item_type
      t.string :title
      t.text :description
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :tutorials
  end
end
