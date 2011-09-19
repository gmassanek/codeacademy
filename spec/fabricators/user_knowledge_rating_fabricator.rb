Fabricator(:user_knowledge_rating) do
  knowledgeable! {Fabricate(:node)}
  knowledge_level {(1..5).to_a.shuffle.first}
end

