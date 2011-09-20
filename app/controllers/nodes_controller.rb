class NodesController < ApplicationController
  autocomplete :node, :title

  def index
    @nodes = Node.all.in_groups(3, false)
    @nodes1 = @nodes[0]
    @nodes2 = @nodes[1]
    @nodes3 = @nodes[2]
  end
  def show
    @node = Node.find(params[:id])
    @link = @node.links.build
    @tweets = @node.tweets
    @stack_results = @node.stack_results
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
    @node.build_site_handle
  end
  def create
    @node = Node.new(params[:node])
    @node.build_site_handle(params[:node][:site_handle_attributes])
    if @node.save
      redirect_to node_path(@node), :notice => "Node created"
    else
      render :action => 'new'
    end
  end
  def update
    @node = Node.find(params[:id])
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
