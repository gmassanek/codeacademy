class RelationshipsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]

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
    @nodes = Node.all.map do |n| {:id => n.id, :title => n.title, :group => 1} end
    @nodeIndexes = {}
    @nodes.each_with_index do |n, i|
      @nodeIndexes[n.fetch(:id)] = i
      @nodes[i].delete(:id)
    end
    @links = Relationship.all.map do |r| {:source=>@nodeIndexes.fetch(r.node1_id), :target=>@nodeIndexes.fetch(r.node2_id), :sentence => r.sentence_from(r.node1) } end
    @jsonResponse = {:nodes => @nodes, :links => @links}

    @relationships = Relationship.all
    respond_to do |format|
      format.html
      format.json {render :json => @jsonResponse}
    end
  end
  def create
    @relationship = Relationship.new(params[:relationship])
    set_user_tracking_columns(@relationship, 'create')
    if @relationship.save
      redirect_to @relationship, :notice => "Relationship created."
    else
      render :action => 'new'
    end
  end
  def show
    @relationship = Relationship.find(params[:id])
    @link = @relationship.links.build
    set_user_tracking_columns(@relationship, 'update')
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
