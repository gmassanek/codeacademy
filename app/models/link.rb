class Link < ActiveRecord::Base
  belongs_to :node
  validates :node, :presence => true
  validates :url, :presence => true
  #validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
end
