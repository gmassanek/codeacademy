class NodesController < ApplicationController
  def index
  end
  def show
    @node = Node.find(params[:id])
  end
end
