class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:post_question]
  
  def home
    @title = "Home"
    @recent_nodes = Node.order('updated_at DESC').limit(8)
    @recent_questions = Tutorial.where(:answered => true).order('updated_at DESC').limit(8)
    @recent_links = Link.order('updated_at DESC').limit(5)

    @unanswered_questions = Tutorial.where(:answered => false)
  end

  def pose_question
    @question = params[:new_question][:question] 
    @question.downcase.gsub(/[^a-z ]/, '')

    @node_matches = []
    Node.all.each do |n|
      title = n.title.downcase.gsub(/[^a-z ]/, '')
      if @question.include? title
        @node_matches << n
      end
    end
  end

  def post_question
    @question = params[:new_question][:question] 
    @question.downcase.gsub(/[^a-z ]/, '')

    @node_matches = []
    Node.all.each do |n|
      title = n.title.downcase.gsub(/[^a-z ]/, '')
      if @question.include? title
        @node_matches << n
      end
    end

    tutorial = Tutorial.new
    if @node_matches.count > 0
      tutorial.item = @node_matches.shuffle.first
    else
      tutorial.item = Node.find_by_title('Ruby on Rails')
    end
    tutorial.title = @question

    tutorial.save

    redirect_to [tutorial.item, tutorial]
  end
end
