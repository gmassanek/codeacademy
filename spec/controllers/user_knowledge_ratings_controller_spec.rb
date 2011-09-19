require File.dirname(__FILE__) + '/../spec_helper'

describe UserKnowledgeRatingsController, :broken => true do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => UserKnowledgeRating.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    UserKnowledgeRating.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    UserKnowledgeRating.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(user_knowledge_rating_url(assigns[:user_knowledge_rating]))
  end

  it "edit action should render edit template" do
    get :edit, :id => UserKnowledgeRating.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    UserKnowledgeRating.any_instance.stubs(:valid?).returns(false)
    put :update, :id => UserKnowledgeRating.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    UserKnowledgeRating.any_instance.stubs(:valid?).returns(true)
    put :update, :id => UserKnowledgeRating.first
    response.should redirect_to(user_knowledge_rating_url(assigns[:user_knowledge_rating]))
  end

  it "destroy action should destroy model and redirect to index action" do
    user_knowledge_rating = UserKnowledgeRating.first
    delete :destroy, :id => user_knowledge_rating
    response.should redirect_to(user_knowledge_ratings_url)
    UserKnowledgeRating.exists?(user_knowledge_rating.id).should be_false
  end
end
