class NodesController < ApplicationController
  def index
    @nodes = Node.all
  end
  def show
    @node = Node.find(params[:id])
  end
  def new
    @node = Node.new
  end
  def create
    @node = Node.new(params[:node])
    if @node.save
      redirect_to @node, :notice => "Node #{@node.title} created"
    else
      render :action => 'new'
    end
  end
  def update
    @node = Node.new(params[:id])
    if @node.update_attributes(params[:node])
      redirect_to @node, :notice => "Node #{@node.title} updated"
    else
      render :action => 'edit'
    end
  end
  def edit
    @node = Node.find(params[:id])
  end
end
