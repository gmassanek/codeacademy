class Link < ActiveRecord::Base
  belongs_to :linkable, :polymorphic => true

  validates :url, :presence => true, :format => {:with => URI::regexp}
  validate :has_node_or_relationship

  def to_s
    "#{linkable.to_s} (#{url})"
  end

  def has_node_or_relationship
    if linkable.blank?
      errors.add(:base, "Must have node or relationship")
    end
  end
end
