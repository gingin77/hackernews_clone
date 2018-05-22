FactoryBot.define do
  factory :user, class: User do
    name "John Doe"
    sequence(:email) { |n| "johndoe#{n}@email.com" }
    password "secret"
  end

  trait :oliver do
    name "Oliver Sacks"
    sequence(:email) { |n| "oliver#{n}@email.com" }
  end

  trait :alice do
    name "Alice Young"
    sequence(:email) { |n| "alicey#{n}@email.com" }
  end
end
