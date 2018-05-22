FactoryBot.define do
  factory :vote do
    value [1, -1].sample
    voteable { build([:url_post, :text_post, :comment].sample) }
    voter { build(:user) }

    trait :down do
      value -1
    end

    trait :up do
      value 1
    end

    trait :url_post do
      voteable { build(:url_post) }
    end

    trait :alice do
      voter { build(:user, :alice) }
    end

    trait :oliver do
      voter { build(:user, :oliver) }
    end

    factory :down_vote, traits: [:down]
    factory :up_vote, traits: [:up]
  end
end
