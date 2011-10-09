Fabricator(:user) do
  email { Faker::Internet.email }
  password {"password"}
  password_confirmation { |user| user.password }
  name {Faker::Lorem.words(3).join(" ")}
end
