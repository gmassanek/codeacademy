class Node < ActiveRecord::Base
  attr_accessor :title, :description
  validates :title, :presence => true
  validates :description, :presence => true
end

