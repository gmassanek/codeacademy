class Tutorial < ActiveRecord::Base
  belongs_to :node, :inverse_of => :tutorials  
  validates :node, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  
  def to_s
    "Tutorial for #{node.to_s}"
  end

end

