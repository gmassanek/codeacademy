Fabricator(:node) do
  title { Faker::Lorem.words(3).join(" ") }
  description {Faker::Lorem.paragraphs(3).join(" ") }
  homepage { |node| "http://www.#{node.title.gsub(" ", "")}.com"}
  created_by! {Fabricate(:user)}
  last_updated_by! {|node| node.created_by}
end
Fabricator(:node_with_links, :from => :node) do
  links!(:count => 3) {|node, i| Fabricate(:node_link, :linkable => node)}
end
