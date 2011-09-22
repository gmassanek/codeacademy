require 'redcarpet'
class TutorialsController < ApplicationController
  def index
    @item = find_item
    @tutorials = @item.tutorials
  end

  def show
    @item = find_item
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @item = find_item
    @tutorial = @item.tutorials.build
  end

  def create
    @item = find_item
    @tutorial = @item.tutorials.create(params[:tutorial])
    set_user_tracking_columns(@tutorial, 'create')
    if @tutorial.save
      redirect_to [@item, @tutorial], :notice => "Successfully created tutorial."
    else
      render :action => 'new'
    end
  end

  def edit
    @item = find_item
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    @item = find_item
    @tutorial = Tutorial.find(params[:id])
    set_user_tracking_columns(@tutorial, 'update')
    if @tutorial.update_attributes(params[:tutorial])
      redirect_to [@item, @tutorial], :notice  => "Successfully updated tutorial."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = find_item
    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy
    redirect_to polymorphic_path([@item, :tutorials]), :notice => "Successfully destroyed tutorial."
  end

  private
  def find_item
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
