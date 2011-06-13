Fabricator(:node) do
  title { Faker::Lorem.words(3).join(" ") }
  description {Faker::Lorem.paragraphs(3).join(" ") }
end
