class Node < ActiveRecord::Base
  attr_accessor :title, :ecosystem, :description
  before_save :default_ecosystem
  def default_ecosystem
    @ecosystem = "Ruby"
  end
end

