class RelationshipsController < ApplicationController
  def new
    @relationship = Relationship.new
    @relationship.links.build
    @relationship.build_site_handle
  end
  def edit
    @relationship = Relationship.find(params[:id])
    @relationship.links.build
  end
  def index
    @relationships = Relationship.all
  end
  def create
    @relationship = Relationship.new(params[:relationship])
    if @relationship.save
      redirect_to @relationship, :notice => "Relationship created."
    else
      render :action => 'new'
    end
  end
  def show
    @relationship = Relationship.find(params[:id])
    @link = @relationship.links.build
    if current_user
      @knowledge_rating = @relationship.user_knowledge_ratings.find_by_user_id(current_user.id)
      unless @knowledge_rating
        @knowledge_rating = @relationship.user_knowledge_ratings.build(:user_id => current_user.id, :knowledge_level => 0)
      end
    end
  end
  def update
    @relationship = Relationship.find(params[:id])
    if @relationship.update_attributes(params[:relationship])
      redirect_to @relationship, :notice => "Relationship updated"
    else
      render :action  => 'edit'
    end
  end
end
