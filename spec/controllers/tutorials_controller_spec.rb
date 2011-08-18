require File.dirname(__FILE__) + '/../spec_helper'

describe TutorialsController, :broken => true do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Tutorial.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid", :broken => true do
    Tutorial.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Tutorial.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(tutorial_url(assigns[:tutorial]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Tutorial.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid", :broken => true do
    Tutorial.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Tutorial.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Tutorial.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Tutorial.first
    response.should redirect_to(tutorial_url(assigns[:tutorial]))
  end

  it "destroy action should destroy model and redirect to index action", :broken => true do
    tutorial = Tutorial.first
    delete :destroy, :id => tutorial
    response.should redirect_to(tutorials_url)
    Tutorial.exists?(tutorial.id).should be_false
  end
end
