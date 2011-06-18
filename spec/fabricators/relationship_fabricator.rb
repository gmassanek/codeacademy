Fabricator(:relationship) do
  node1_id {Fabricate(:node).id}
  node2_id {Fabricate(:node).id}
  sentence1 {"#{Faker::Lorem.words(3).join(" ")} %1 #{Faker::Lorem.words(2).join(" ")} %2 #{Faker::Lorem.words(1).join(" ")}"}
  sentence2 {"#{Faker::Lorem.words(1).join(" ")} %2 #{Faker::Lorem.words(2).join(" ")} %1 #{Faker::Lorem.words(2).join(" ")}"}
end
