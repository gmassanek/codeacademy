class RelationshipsController < ApplicationController
  def new
    @relationship = Relationship.new
  end
  def create
    @relationship = Relationship.new(params[:relationship])
    if @relationship.save
      redirect_to @relationship, :notice => "Relationship between #{Node.find(@relationship.node1_id).title} and #{Node.find(@relationship.node2_id).title} created."
    else
      render :action => 'new'
    end
  end
  def show
    @relationship = Relationship.find(params[:id])
  end
end
