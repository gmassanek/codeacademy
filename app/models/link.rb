class Link < ActiveRecord::Base
  belongs_to :linkable, :polymorphic => true
  has_one :created_by, :foreign_key => 'id', :class_name => "User"
  has_one :last_updated_by, :foreign_key => 'id', :class_name => "User"

  validates :url, :presence => true, :format => {:with => URI::regexp}
  validates_length_of :description, :maximum => 140
  
  def to_s
    return description unless description.blank?
    show_width = 40
    if url.length > show_width
      url[0, show_width] + "..."
    else
      url
    end
  end
end
