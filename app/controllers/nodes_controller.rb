class NodesController < ApplicationController
  autocomplete :node, :title, :full => true, :extra_data => [:cached_slug]

  before_filter :authenticate_user!, :except => [:show, :index, :autocomplete_node_title_nodes ]

  def index
    @nodes = Node.all.in_groups(3, false)
    @unanswered = Tutorial.where(:answered => false)
    @recently_answered = Tutorial.where(:answered => true, :updated_at => (Time.now - 7.days) .. (Time.now))
  end
  def show
    @node = Node.find(params[:id])
    @link = @node.links.build
    if current_user
      @knowledge_rating = @node.user_knowledge_ratings.find_by_user_id(current_user.id)
      unless @knowledge_rating
        @knowledge_rating = @node.user_knowledge_ratings.build(:user_id => current_user.id, :knowledge_level => 0)
      end
    end
  end
  def new
    @node = Node.new
    @node.links.build
  end
  def create
    @node = Node.new(params[:node])
    set_user_tracking_columns(@node, 'create')
    if @node.save
      redirect_to node_path(@node), :notice => "Node created"
    else
      render :action => 'new'
    end
  end
  def update
    @node = Node.find(params[:id])
    set_user_tracking_columns(@node, 'update')
    if @node.update_attributes(params[:node])
      redirect_to node_path(@node), :notice => "Node updated"
    else
      render :action => 'edit'
    end
  end
  def edit
    @node = Node.find(params[:id])
    @node.links.build
  end
  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    redirect_to nodes_path, :notice => "Node deleted"
  end
end
