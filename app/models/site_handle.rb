class SiteHandle < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  #validates :item, :presence => true

  def to_s
    "Handles for #{item.to_s}"
  end

  def handles
    handles = self.attributes
    self.attributes.each do |key, value|
      if value.blank? || key.include?("id") || key.include?("item")
        handles.delete(key)
      end
    end
    return handles
  end

  def link_to(handle)
    case handle
    when "github"
      "http://www.github.com/#{handles[handle]}"
    when "twitter"
      "http://www.twitter.com/##{handles[handle]}"
    else
      "http://www.#{handle}.com/#{handles[handle]}"
    end
  end
end
