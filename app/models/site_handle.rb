class SiteHandle < ActiveRecord::Base
  belongs_to :node, :inverse_of => :site_handle
  validates :node, :presence => true

  def to_s
    "Handles for #{node.to_s}"
  end

  def handles
    handles = self.attributes
    self.attributes.each do |key, value|
      if value.blank? || key.include?("id")
        handles.delete(key)
      end
    end
    return handles
  end
  def link_to(handle)
    case handle
    when "github"
      "http://www.github.com/#{handles[handle]}"
    else
      "http://www.#{handle}.com/#{handles[handle]}"
    end
  end
end
