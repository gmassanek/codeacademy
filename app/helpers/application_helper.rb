module ApplicationHelper

  def relationship_sentence_with_link(relationship, node)
    sentence = relationship.sentence_from(node, :filled_with => nil)
    othernode = relationship.other_node(node)
    link = "<a href='#{node_url(othernode)}' id=node_#{othernode.id}>#{othernode.to_s}</a>"
    if sentence == relationship.sent1(:filled_with => nil)
      relationship.populate(sentence, {:val1 => node.to_s, :val2 => link})
    else
      relationship.populate(sentence,{:val1 => link, :val2 => node.to_s})
    end
  end

  def relationship_sentence_with_links(relationship)
    sentence = relationship.sent1(:filled_with => nil)
    node1 = relationship.node1
    link1 = link_to node1.to_s, node_path(node1)
    node2  = relationship.node2
    link2 = link_to node2.to_s, node_path(node2)
    relationship.populate(sentence, {:val1 => link1, :val2 => link2})
  end

  def link_to_remove_fields(name, f)
    f.input(:_destroy, :as => "hidden") + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
    #link_to_function(name, h("add_fields(this, \"#{association}\", \"<hr>\")"))
    #link_to_function(name, "add_fields(this, :link, '<hr>')")
  end

  def link_to_site_handle(handle, link)
    image = image_tag "#{handle}.png", :id => "#{handle}LinkImage", :height => "32px"
    link_to image, link
  end
end
