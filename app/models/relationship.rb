class Relationship < ActiveRecord::Base
  belongs_to :node1, :class_name => "Node"
  belongs_to :node2, :class_name => "Node"
  before_validation :fillKey
  validates :node1_id, :presence => true
  validates :node2_id, :presence => true
  validates :sentence1, :presence => true
  validates :sentence2, :presence => true
  validates :key, :uniqueness => true
  validate :has_space_holders
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
    if sentence1.nil? or sentence2.nil? 
      return
    end
    if !sentenceValid?(sentence1)
      errors.add(:sentence1, ' needs to have %1 and %2')
    end
    if !sentenceValid?(sentence2)
      errors.add(:sentence2, ' needs to have %1 and %2')
    end
  end
  def populateSentence(sentence)
    #I don't like this, come up with a better way
    sentence["%1"]=node1.to_s
    sentence["%2"]=node2.to_s
    sentence
  end
  def sentenceValid?(sentence)
    sentence.split.include?('%1') and sentence.split.include?('%2')
  end
end
