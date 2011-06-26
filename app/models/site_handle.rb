class SiteHandle < ActiveRecord::Base
  belongs_to :node, :inverse_of => :site_handle
  validates :node, :presence => true

  def to_s
    "Handles for #{node.to_s}"
  end
end
