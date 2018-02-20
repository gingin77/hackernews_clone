FactoryBot.define do
  factory :vote do
    value 1
    voteable { build(:url_post) }
    voter { build(:oliver) }

    trait :down_vote do
      value -1
    end

    trait :up_vote do
      value 1
    end

    factory :down_vote, traits: [:down_vote]
    factory :up_vote, traits: [:up_vote]
  end
end
