class Node < ActiveRecord::Base
  require 'twitter_helper'
  require 'rubyoverflow'
  include Rubyoverflow

  has_many :relationships1, :class_name => 'Relationship', :foreign_key => 'node1_id'
  has_many :relationships2, :class_name => 'Relationship', :foreign_key => 'node2_id'
  has_many :links, :inverse_of => :node
  has_many :tutorials, :inverse_of => :node
  has_one :site_handle, :inverse_of => :node
  

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :homepage, :format => {:with => URI::regexp}, :allow_blank => true

  validates :confidence, :numericality => {:only_integer => true}, :inclusion  => {:in => 1..5}, :allow_nil => true

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

#  def tutorials
#    return tutorial.tutorials unless tutorial.nil?
#  end

  def self.all(*args)
    self.find(:all, :order => "title")  
  end

  def tweets
    return TwitterHelper.twitter_search_for(twitter_search_key, :html => true) unless twitter_search_key.blank?
    #return []
  end
  def stack_results
    search_results =  Questions.retrieve_by_tag(stack_search_key, :page_size => 5) unless stack_search_key.blank?
    results = []
    search_results.questions.each do |q|
      thread = {:title => q.title, :answers_url => q.question_answers_url}
      a << thread
    end
    return search_results
  end
end
