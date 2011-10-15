class PagesController < ApplicationController
  
  def home
    @title = "Home"
    @tutorial = Tutorial.new
  end
  #def node_search_by_title
  #  @node = Node.find_by_title(params[:title])
  #  if @node.nil?
  #    redirect_to new_node_path, :notice => "Node #{params[:title]} does not exist"
  #  else
  #    redirect_to @node
  #  end
  #end
end
