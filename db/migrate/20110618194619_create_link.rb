class CreateLink < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :url
      t.integer :node_id

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
