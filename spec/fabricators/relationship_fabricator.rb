Fabricator(:relationship) do
  node1! {Fabricate(:node)}
  node2! {Fabricate(:node)}
  sentence1 {"#{Faker::Lorem.words(3).join(" ")} %1 #{Faker::Lorem.words(2).join(" ")} %2 #{Faker::Lorem.words(1).join(" ")}"}
  sentence2 {"#{Faker::Lorem.words(1).join(" ")} %2 #{Faker::Lorem.words(2).join(" ")} %1 #{Faker::Lorem.words(2).join(" ")}"}
  created_by! {Fabricate(:user)}
  last_updated_by! {|node| node.created_by}
end
