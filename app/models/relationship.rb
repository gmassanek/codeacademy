class Relationship < ActiveRecord::Base
  belongs_to :node1, :class_name => "Node"
  belongs_to :node2, :class_name => "Node"
  validates :node1_id, :presence => true
  validates :node2_id, :presence => true
  validates :sentence1, :presence => true
  validates :sentence2, :presence => true
  validate :has_space_holders
  #attr_accessible :node1_id, :node2_id
  def sentence1to2
    puts self.inspect
    sentence1["%1"]=node1.to_s
    sentence1["%2"]=node2.to_s
    sentence1
  end
  def sentence2to1
    sentence2["%1"]=node1.to_s
    sentence2["%2"]=node2.to_s
    sentence1
  end
  def has_space_holders
    if sentence1.nil? or sentence2.nil? 
      return
    end
    if !sentence1.split.include?('%1') or !sentence1.split.include?('%2')
      errors.add(:sentence1, ' needs to have %1 and %2')
    end
    if !sentence2.split.include?('%1') or !sentence2.split.include?('%2')
      errors.add(:sentence2, ' needs to have %1 and %2')
    end
  end
end
