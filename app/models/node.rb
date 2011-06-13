class Node < ActiveRecord::Base
  #attr_accessor :title, :description
  validates :title, :presence => true
  validates :description, :presence => true
  def to_s
    self.title
  end
end

