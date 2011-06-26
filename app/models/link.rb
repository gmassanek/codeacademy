class Link < ActiveRecord::Base
  belongs_to :node, :inverse_of => :links
  belongs_to :relationship, :inverse_of => :links
  validates :url, :presence => true, :format => {:with => URI::regexp}
  validate :has_node_or_relationship

  def to_s
    "#{node.to_s} (#{url})"
  end

  def has_node_or_relationship
    if node.blank? and relationship.blank?
      errors.add(:base, "Must have node or relationship")
    end
  end
end
