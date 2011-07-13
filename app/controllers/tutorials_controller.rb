class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.all
  end
  def show
    @tutorial = Tutorial.find(params[:id])
  end
  def new
    @tutorial = Tutorial.new
  end
  def create
    @tutorial = Tutorial.new(params[:tutorial])
    if @tutorial.save
      redirect_to tutorials_path, :notice => "Tutorial created"
    else
      render :action => 'new'
    end
  end
  def update
    @tutorial = Tutorial.find(params[:id])
    if @tutorial.update_attributes(params[:tutorial])
      redirect_to tutorials_path, :notice => "Tutorial updated"
    else
      render :action => 'edit'
    end
  end
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def delete
    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy
    redirect_to tutorials_path, :notice => "Tutorial deleted"
  end
end
