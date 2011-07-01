class Node < ActiveRecord::Base
  #include TwitterHelper

  has_many :relationships1, :class_name => 'Relationship', :foreign_key => 'node1_id'
  has_many :relationships2, :class_name => 'Relationship', :foreign_key => 'node2_id'
  has_many :links, :inverse_of => :node
  has_one :site_handle, :inverse_of => :node
  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :homepage, :format => {:with => URI::regexp}, :allow_blank => true
  accepts_nested_attributes_for :links, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :site_handle
  has_friendly_id :title, :use_slug => true

  def to_s
    title
  end
  
  def relationships
    relationships1 | relationships2
  end
  
  def related_nodes
    relationships.each.collect do |r|
      if r.node1_id == self.id
        r.node2
      else
        r.node1
      end
    end
  end

  def getHandle(handle)
    site_handle[handle]
  end

  def handles
    return site_handle.handles unless site_handle.nil?
  end

  def self.all(*args)
    self.find(:all, :order => "title")  
  end

  def tweets
    query = CGI.escape(title)
    search = Twitter::Search.new
    #a = search.containing(query).language("en").result_type("recent").per_page(5).collect {|tweet| tweet}
    []
  end
end
