Fabricator(:node_tutorial, :class_name => :tutorial) do
  title { Faker::Lorem.words(3).join(" ") }
  item! {Fabricate(:node)}
  description {Faker::Lorem.paragraphs(3).join(" ") }
  content {Faker::Lorem.paragraphs(8).join(" ") }
  created_by! {Fabricate(:user)}
  last_updated_by! {|node| node.created_by}
end
Fabricator(:relationship_tutorial, :class_name => :tutorial) do
  title { Faker::Lorem.words(3).join(" ") }
  item! {Fabricate(:relationship)}
  description {Faker::Lorem.paragraphs(3).join(" ") }
  content {Faker::Lorem.paragraphs(8).join(" ") }
  created_by! {Fabricate(:user)}
  last_updated_by! {|node| node.created_by}
end
