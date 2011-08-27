Fabricator(:user) do
  email { Faker::Internet.email }
  password {"password"}
  password_confirmation { |user| user.password }
end
