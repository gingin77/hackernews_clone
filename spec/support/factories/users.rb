FactoryBot.define do
  factory :oliver, class: User do
    name "Oliver Sacks"
    sequence(:email) { |n| "oliver#{n}@email.com" }
    password "secret"
  end

  factory :alice, class: User do
    name "Alice Young"
    sequence(:email) { |n| "alicey#{n}@email.com" }
    password "secret"
  end
end
