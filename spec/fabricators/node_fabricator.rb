Fabricator(:node) do
  title { Faker::Lorem.words(3).join(" ") }
  description {Faker::Lorem.paragraphs(3).join(" ") }
  homepage { |node| "http://www.#{node.title.gsub(" ", "")}.com"}
end
Fabricator(:node_with_links, :from => :node) do
  links(:counts => 3) {|node, i| Fabricate(:link, :node => node)}
end
