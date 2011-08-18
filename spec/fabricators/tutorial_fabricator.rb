Fabricator(:node_tutorial, :class_name => :tutorial) do
  title { Faker::Lorem.words(3).join(" ") }
  item! {Fabricate(:node)}
  description {Faker::Lorem.paragraphs(3).join(" ") }
  content {Faker::Lorem.paragraphs(8).join(" ") }
end
