class Link < ActiveRecord::Base
  belongs_to :node, :inverse_of => :links
  #validates :node_id, :presence => true, :unless => lambda {|link| link.node.try(:valid?)}
  validates :node, :presence => true
  validates :url, :presence => true, :format => {:with => URI::regexp}

  def to_s
    "#{node.to_s} (#{url})"
  end
end

