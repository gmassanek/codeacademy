class CreateUserKnowledgeRatings < ActiveRecord::Migration
  def self.up
    create_table :user_knowledge_ratings do |t|
      t.integer :user_id
      t.integer :knowledgeable_id
      t.string :knowledgeable_type
      t.integer :knowledge_level
      t.timestamps
    end
  end

  def self.down
    drop_table :user_knowledge_ratings
  end
end
