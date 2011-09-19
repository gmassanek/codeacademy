class UserKnowledgeRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :knowledgeable, :polymorphic => true
  attr_accessible :user_id, :knowledgeable_id, :knowledgeable_type, :knowledge_level

end
