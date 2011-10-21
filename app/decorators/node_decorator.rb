class NodeDecorator < ApplicationDecorator
  decorates :node

  def title
    unless node.homepage.blank?
      h.link_to node, node.homepage, :target => '_blank'
    else
      node
    end
  end

  def to_s
    node.title
  end

end
