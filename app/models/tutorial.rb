class Tutorial < ActiveRecord::Base
  belongs_to :item, :polymorphic => true

  attr_accessible :item_id, :item_type, :title, :description, :content

  validates :title, :presence => true
  validates :description, :presence => true
  validates :content, :presence => true

  def to_s
    title
  end
end
