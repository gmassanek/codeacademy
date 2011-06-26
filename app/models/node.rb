class Node < ActiveRecord::Base
  has_many :relationships1, :class_name => 'Relationship', :foreign_key => 'node1_id'
  has_many :relationships2, :class_name => 'Relationship', :foreign_key => 'node2_id'
  has_many :links, :inverse_of => :node
  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :homepage, :format => {:with => URI::regexp}, :allow_blank => true
  accepts_nested_attributes_for :links, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true
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
  def self.all(*args)
    self.find(:all, :order => "title")  
  end
end
