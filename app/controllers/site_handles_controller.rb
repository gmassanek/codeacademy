class SiteHandlesController < ApplicationController
  def index
    @siteHandles = SiteHandle.all
  end
  def show
    @siteHandle = SiteHandle.find(params[:id])
  end
  def new
    @siteHandle = SiteHandle.new
  end
  def create
    @siteHandle = SiteHandle.new(params[:site_handle])
    if @siteHandle.save
      redirect_to site_handles_path, :notice => "Site Handle created"
    else
      render :action => 'new'
    end
  end
  def update
    @siteHandle = SiteHandle.find(params[:id])
    if @siteHandle.update_attributes(params[:site_handle])
      redirect_to site_handles_path, :notice => "Site Handle updated"
    else
      render :action => 'edit'
    end
  end
  def edit
    @siteHandle = SiteHandle.find(params[:id])
  end
end
