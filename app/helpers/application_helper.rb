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
end
