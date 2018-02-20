FactoryBot.define do
  factory :vote do
    value [1, -1].sample
    voteable { build([:url_post, :text_post, :comment].sample) }
    voter { build([:oliver, :alice].sample) }

    trait :down do
      value -1
    end

    trait :up do
      value 1
    end

    factory :down_vote, traits: [:down]
    factory :up_vote, traits: [:up]
  end
end
