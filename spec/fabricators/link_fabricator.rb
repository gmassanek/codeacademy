Fabricator(:user_helpfulness_rating) do
  user! {Fabractate(:user)
  url { |link| "http://www.#{link.linkable.to_s.gsub(" ", "")}.com"}
end
Fabricator(:node_link, :from => :link) do
  linkable! {Fabricate(:node)}
  url { |link| "http://www.#{link.linkable.to_s.gsub(" ", "")}.com"}
end
Fabricator(:relationship_link, :from => :link) do
  linkable! {Fabricate(:relationship)}
  url { |link| "http://www.#{link.linkable.to_s.gsub(" ", "")}.com"}
end
