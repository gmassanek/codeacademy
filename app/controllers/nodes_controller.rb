class NodesController < ApplicationController
  def index
    @nodes = Node.all
  end
  def show
    @node = Node.find(params[:id])
    @tweets = @node.tweets
  end
  def new
    @node = Node.new
    @node.links.build
    @node.build_site_handle
  end
  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to node_path(@node), :notice => "Node #{@node.to_s} created"
    else
      render :action => 'new'
    end
  end
  def update
    puts "helloooooooooooooooo"
    @node = Node.find(params[:id])
    if @node.update_attributes(params[:node])
      redirect_to node_path(@node), :notice => "Node #{@node} updated"
    else
      render :action => 'edit'
    end
  end
  def edit
    @node = Node.find(params[:id])
    @node.links.build
    @node.build_site_handle if @node.site_handle.blank?
  end
  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    redirect_to nodes_path, :notice => "Node deleted"
  end
end
