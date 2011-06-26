Fabricator(:link) do
  node_id {Fabricate(:node).id}
  url { |link| "http://www.#{link.node.title.gsub(" ", "")}.com"}
end
Fabricator(:node_link, :from => :link)
Fabricator(:relationship_link, :class_name => :link) do
  relationship_id {Fabricate(:relationship).id}
  url { |link| "http://www.#{link.relationship.node1.title.gsub(" ", "")}.com"}
end
