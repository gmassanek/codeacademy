class Relationship < ActiveRecord::Base
  
  belongs_to :node1, :class_name => "Node"
  belongs_to :node2, :class_name => "Node"
  
  has_one :created_by, :foreign_key => 'id', :class_name => "User"
  has_one :last_updated_by, :foreign_key => 'id', :class_name => "User"
  has_many :links, :as => :linkable
  has_many :user_knowledge_ratings, :as => :knowledgeable
  has_many :tutorials, :as => :item
  
  accepts_nested_attributes_for :links, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true


  before_validation :fillKey
  validate :has_space_holders, :allow_nil => true
  validate :not_self_referencing
  validates :node1, :presence => true
  validates :node2, :presence => true
  validates :sentence1, :presence => true
  validates :sentence2, :presence => true
  validates :key, :uniqueness => true

  def not_self_referencing
    errors.add(:node1, 'cannot be the same as node 2') if node1_id == node2_id
  end
  
  def to_s
    "#{node1.to_s} and #{node2.to_s}"
  end

  def fillKey
    unless node1.nil? or node2.nil?
      if node1_id<node2_id
        self.key = "#{node1_id}:#{node2_id}"
      else
        self.key = "#{node2_id}:#{node1_id}"
      end
    end
  end

  def sentence_from(node, options = {:filled_with => 'nodes'})
    if node1_id == node.id
      sent1(options)
    else
      sent2(options)
    end
  end

  def other_node(node)
    if node1_id == node.id
      return Node.find(node2_id)
    else
      return Node.find(node1_id)
    end
  end

  def sent1(options = {:filled_with => 'nodes'})
    if options[:filled_with] == 'nodes'
      return populate(sentence1)
    else
      return sentence1
    end
  end

  def sent2(options = {:filled_with => 'nodes'})
    if options[:filled_with] == 'nodes'
      return populate(sentence2)
    else
      return sentence2
    end
  end

  def has_space_holders
    if !sentence1.nil? and !sentenceValid?(sentence1)
      errors.add(:sentence1, ' needs to have %1 and %2')
    end
    if !sentence2.nil? and !sentenceValid?(sentence2)
      errors.add(:sentence2, ' needs to have %1 and %2')
    end
  end

  def populate(sentence, options = {:val1 => node1.to_s, :val2 => node2.to_s})
    sentence.sub("%1", options[:val1]).sub("%2", options[:val2]).html_safe
  end

  def sentenceValid?(sentence)
    sentence.include?('%1') and sentence.include?('%2')
  end
end
