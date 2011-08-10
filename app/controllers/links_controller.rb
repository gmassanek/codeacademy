class LinksController < ApplicationController
  def index
    @linkable = find_linkable
    @links = Link.all
  end
  def show
    @link = Link.find(params[:id])
  end
  def new
    @link = Link.new
  end
  def create
    @linkable = find_linkable
    @link = @linkable.links.build(params[:link])
    if @link.save
      flash[:notice] = "Link created"
      redirect_to :id => nil
    else
      render :action => 'new'
    end
  end
  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to links_path, :notice => "Link updated"
    else
      render :action => 'edit'
    end
  end
  def edit
    @link = Link.find(params[:id])
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
