class AddAnsweredToTutorials < ActiveRecord::Migration
  def self.up
    add_column :tutorials, :answered, :boolean
  end

  def self.down
    remove_column :tutorials, :answered
  end
end
