class NodesController < ApplicationController
  autocomplete :node, :title

  def index
    @nodes = Node.all
  end
  def show
    @node = Node.find(params[:id])
    @link = @node.links.build
    @tweets = @node.tweets
    @stack_results = @node.stack_results
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
