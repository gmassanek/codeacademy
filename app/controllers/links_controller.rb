class LinksController < ApplicationController
  def index
    @linkable = find_linkable
    @links = @linkable.links
  end
  def show
    @link = Link.find(params[:id])
  end
  def new
    @linkable = find_linkable
    @link = Link.new
  end
  def create
    @linkable = find_linkable
    @link = @linkable.links.build(params[:link])
    if @link.save
      flash[:notice] = "Link created"
      redirect_to @linkable
    else
      render :action => 'new'
    end
  end
  def update
    @linkable = find_linkable
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:notice] = "Link updated"
      redirect_to @linkable
    else
      render :action => 'edit'
    end
  end
  def edit
    @linkable = find_linkable
    @link = Link.find(params[:id])
  end

  def destroy
    @linkable = find_linkable
    @link = Link.find(params[:id])
    @link.destroy
    flash[:notice] = "Link deleted"
    redirect_to @linkable
  end
  
  private
  def find_linkable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
