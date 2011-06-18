Fabricator(:link) do
  node_id {Fabricate(:node).id}
  url { |link| "http://www.#{link.node.title.gsub(" ", "")}.com"}
end
