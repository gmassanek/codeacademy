Fabricator(:node) do
  title { Faker::Lorem.words(3).join(" ") }
  description {Faker::Lorem.paragraphs(3).join(" ") }
  homepage { |node| "http://www.#{node.title.gsub(" ", "")}.com"}
  site_handle! {|node, i| Fabricate(:site_handle, :item => node, :github => "node.title")}
end
Fabricator(:node_with_links, :from => :node) do
  links!(:count => 3) {|node, i| Fabricate(:node_link, :linkable => node)}
end
