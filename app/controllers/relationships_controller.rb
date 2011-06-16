class RelationshipsController < ApplicationController
  def new
    @relationship = Relationship.new
  end
  def edit
    @relationship = Relationship.find(params[:id])
  end
  def index
    @relationships = Relationship.all
  end
  def create
    @relationship = Relationship.new(params[:relationship])
    if @relationship.save
      redirect_to @relationship, :notice => "Relationship between #{@relationship.node1.title} and #{@relationship.node2.title} created."
    else
      render :action => 'new'
    end
  end
  def show
    @relationship = Relationship.find(params[:id])
  end
end
