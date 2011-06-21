class Link < ActiveRecord::Base
  belongs_to :node, :inverse_of => :links
  #validates :node_id, :presence => true, :unless => lambda {|link| link.node.try(:valid?)}
  validates_presence_of :node
  validates :url, :presence => true

  def to_s
    "#{node.to_s} (#{url})"
  end
end

