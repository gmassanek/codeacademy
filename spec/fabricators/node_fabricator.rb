Fabricator(:node) do
  title { Faker::Lorem.sentence }
  description {Faker::Lorem.paragraphs(3).join("\n") }
  #ecosystem {"Ruby"}
end
