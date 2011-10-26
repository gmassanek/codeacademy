class Relationship < ActiveRecord::Base
  require 'relationships/key'
  require 'relationships/sentences'
  
  belongs_to :node1, :class_name => "Node"
  belongs_to :node2, :class_name => "Node"
  
  has_one :created_by, :foreign_key => 'id', :class_name => "User"
  has_one :last_updated_by, :foreign_key => 'id', :class_name => "User"
  has_many :links, :as => :linkable
  has_many :user_knowledge_ratings, :as => :knowledgeable
  has_many :tutorials, :as => :item
  
  accepts_nested_attributes_for :links, :reject_if => :all_blank, :allow_destroy => true

  before_validation :fillKey

  validates :key, :uniqueness => true, :presence => true
  validates :node1, :presence => true
  validates :node2, :presence => true
  validate :valid_sentences

  def to_s
    "#{node1.to_s} and #{node2.to_s}"
  end

  def fillKey
    self.key = RelHelper::Key.create(node1,node2)
  end

  def sentence_from(node)
    if node1 == node
      populated_sentence(:sentence1)
    else
      populated_sentence(:sentence2)
    end
  end

  def other_node(node)
    if node1 == node
      return node2
    else
      return node1
    end
  end

  def populated_sentence(which_sentence)
    sentence = self.send(which_sentence)
    rescue 
      return
    else
      RelHelper::Sentences.populate(sentence, node1.to_s, node2.to_s)
  end

  private

  def valid_sentences
    unless RelHelper::Sentences.valid_sentence?(sentence1) 
      errors.add(:sentence1, ' needs to have %1 and %2')
    end
    unless RelHelper::Sentences.valid_sentence?(sentence2)
      errors.add(:sentence2, ' needs to have %1 and %2')
    end
  end

end
