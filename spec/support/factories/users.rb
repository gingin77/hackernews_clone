FactoryBot.define do
  factory :user_a, class: User do
    name "Oliver Sacks"
    sequence(:email) { |n| "olivers#{n}@email.com" }
    password "secret"
  end

  factory :user_b, class: User do
    name "Ed Young"
    sequence(:email) { |n| "edy#{n}@email.com" }
    password "secret"
  end
end
