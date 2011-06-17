class Node < ActiveRecord::Base
  has_many :relationships1, :class_name => 'Relationship', :foreign_key => 'node1_id'
  has_many :relationships2, :class_name => 'Relationship', :foreign_key => 'node2_id'
  validates :title, :presence => true
  validates :description, :presence => true
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
end

