Fabricator(:relationship) do
  node1_id {Fabricator(:node)}
  node2_id {Fabricator(:node)}
  sentence1 {"#{Faker::Lorem.words(3).join(" ")} #{node1} #{Faker::Lorem.words(2).join(" ")} #{node2 } #{Faker::Lorem.words(1).join(" ")}"}
  sentence2 {"#{Faker::Lorem.words(1).join(" ")} #{node2} #{Faker::Lorem.words(2).join(" ")} #{node1 } #{Faker::Lorem.words(2).join(" ")}"}
end
