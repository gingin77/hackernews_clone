FactoryBot.define do
  factory :user do
    name "Oliver Sacks"
    sequence(:email) { |n| "olivers#{n}@email.com" }
    password "secret"
  end
end
