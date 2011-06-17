class Relationship < ActiveRecord::Base
  belongs_to :node1, :class_name => "Node"
  belongs_to :node2, :class_name => "Node"
  
  before_validation :fillKey

  validate :has_space_holders, :allow_nil => true
  validate :not_self_referencing

  validates :node1_id, :presence => true
  validates :node2_id, :presence => true
  validates :sentence1, :presence => true
  validates :sentence2, :presence => true
  validates :key, :uniqueness => true

  def not_self_referencing
    errors.add(:node1, 'cannot be the same as node 2') if node1_id == node2_id
  end
  def fillKey
    if node1_id<node2_id
      self.key = "#{node1_id}:#{node2_id}"
    else
      self.key = "#{node2_id}:#{node1_id}"
    end
  end
  def sentence1to2
    populateSentence(sentence1)
  end
  def sentence2to1
    populateSentence(sentence2)
  end
  def has_space_holders
    if !sentence1.nil? and !sentenceValid?(sentence1)
      errors.add(:sentence1, ' needs to have %1 and %2')
    end
    if !sentence2.nil? and !sentenceValid?(sentence2)
      errors.add(:sentence2, ' needs to have %1 and %2')
    end
  end
  def populateSentence(sentence)
    sentence.sub("%1", node1.title).sub("%2", node2.title)
  end
  def sentenceValid?(sentence)
    sentence.include?('%1') and sentence.include?('%2')
  end
end
