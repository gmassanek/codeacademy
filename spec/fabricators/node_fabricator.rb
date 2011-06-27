Fabricator(:node) do
  title { Faker::Lorem.words(3).join(" ") }
  description {Faker::Lorem.paragraphs(3).join(" ") }
  homepage { |node| "http://www.#{node.title.gsub(" ", "")}.com"}
  site_handle {|node, i| Fabricate(:site_handle, :node => node, :github => nil)}
end
Fabricator(:node_with_links, :from => :node) do
  links(:count => 3) {|node, i| Fabricate(:link, :node => node)}
end
Fabricator(:node_with_site_handles, :from => :node) do
  site_handle {|node, i| Fabricate(:site_handle, :node => node)}
end
