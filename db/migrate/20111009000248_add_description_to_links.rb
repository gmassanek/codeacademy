class AddDescriptionToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :description, :text
  end

  def self.down
    remove_column :links, :description
  end
end
