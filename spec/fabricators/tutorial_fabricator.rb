Fabricator(:tutorial) do
  node_id {Fabricate(:node).id}
  title { Faker::Lorem.words(3).join(" ") }
  description { Faker::Lorem.paragraphs(3).join(" ") }
end
