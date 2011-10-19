class PagesController < ApplicationController
  
  def home
    @title = "Home"
    @tutorial = Tutorial.new
  end

end
