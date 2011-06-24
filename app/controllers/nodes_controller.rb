class NodesController < ApplicationController
  def index
    @nodes = Node.all
  end
  def show
    @node = Node.find(params[:id])
  end
  def new
    @node = Node.new
    @node.links.build
  end
  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to nodes_path, :notice => "Node #{@node.to_s} created"
    else
      render :action => 'new'
    end
  end
  def update
    @node = Node.find(params[:id])
    if @node.update_attributes(params[:node])
      redirect_to nodes_path, :notice => "Node #{@node} updated"
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
