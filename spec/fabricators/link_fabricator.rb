Fabricator(:node_link, :from => :link) do
  linkable! {Fabricate(:node)}
  url { |link| "http://www.#{link.linkable.to_s.gsub(" ", "")}.com"}
  created_by! {Fabricate(:user)}
  last_updated_by! {|node| node.created_by}
end
Fabricator(:relationship_link, :from => :link) do
  linkable! {Fabricate(:relationship)}
  url { |link| "http://www.#{link.linkable.to_s.gsub(" ", "")}.com"}
  created_by! {Fabricate(:user)}
  last_updated_by! {|node| node.created_by}
end
