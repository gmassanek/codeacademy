class NodesController < ApplicationController
  def index
  end
  def show
    @node = Node.find(params[:id])
  end
  def new
    @node = Node.new
  end
  def create
    @node = Node.new(params[:node])
    @node.save!
    flash[:notice] = "Node #{@node.title} created"
    redirect_to node_path(@node)
  end
end
