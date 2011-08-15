class SiteHandlesController < ApplicationController
  def index
    @site_handles = SiteHandle.all
  end
  def show
    @site_handle = SiteHandle.find(params[:id])
  end
  def new
    @item = find_item
    @site_handle = SiteHandle.new 
  end
  def create
    @item = find_item
    @site_handle = @item.build_site_handle(params[:site_handle])
    if @site_handle.save
      flash[:notice] = "Site Handle created"
      redirect_to @item
    else
      render :action => 'new'
    end
  end
  def update
    @item = find_item
    @site_handle = SiteHandle.find(params[:id])
    if @site_handle.update_attributes(params[:link])
      flash[:notice] = "Site Handle updated"
      redirect_to @item
    else
      render :action => 'edit'
    end
  end
  def edit
    @item = find_item
    @site_handle = SiteHandle.find(params[:id])
  end

  def destroy
    @item = find_item
    @site_handle = SiteHandle.find(params[:id])
    @site_handle.destroy
    flash[:notice] = "SiteHandle deleted"
    redirect_to @item
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
