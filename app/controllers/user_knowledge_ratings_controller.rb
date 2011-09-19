class UserKnowledgeRatingsController < ApplicationController
  def index
    @user_knowledge_ratings = UserKnowledgeRating.all
    @knowledge_rateable = find_knowledge_ratable
  end

  def show
    @knowledge_rateable = find_knowledge_ratable
    @user_knowledge_rating = UserKnowledgeRating.find(params[:id])
  end

  def new
    @user_knowledge_rating = UserKnowledgeRating.new
    @knowledge_rateable = find_knowledge_ratable
  end

  def create
    @knowledge_rateable = find_knowledge_ratable
    @user_knowledge_rating = UserKnowledgeRating.new(params[:user_knowledge_rating])
    @user_knowledge_rating.user = current_user
    if @user_knowledge_rating.save
      redirect_to @knowledge_rateable, :notice => "Successfully created user knowledge rating."
    else
      render :action => 'new'
    end
  end

  def edit
    @knowledge_rateable = find_knowledge_ratable
    @user_knowledge_rating = UserKnowledgeRating.find(params[:id])
  end

  def update
    @knowledge_rateable = find_knowledge_ratable
    @user_knowledge_rating = UserKnowledgeRating.find(params[:id])
    if @user_knowledge_rating.update_attributes(params[:user_knowledge_rating])
      redirect_to @knowledge_rateable, :notice  => "Successfully updated user knowledge rating."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @knowledge_rateable = find_knowledge_ratable
    @user_knowledge_rating = UserKnowledgeRating.find(params[:id])
    @user_knowledge_rating.destroy
    redirect_to @knowledge_rateable, :notice => "Successfully destroyed user knowledge rating."
  end

  private
  def find_knowledge_ratable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
