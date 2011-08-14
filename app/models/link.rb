class Link < ActiveRecord::Base
  belongs_to :linkable, :polymorphic => true
  validates :linkable, :presence => true

  validates :url, :presence => true, :format => {:with => URI::regexp}

  def to_s
    "#{linkable.to_s} (#{url})"
  end
end
