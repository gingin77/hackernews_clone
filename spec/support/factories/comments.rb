FactoryBot.define do
  factory :comment do
    text "Yay, plants!!!!!"
    submitter { build(:alice) }
    commentable { create([:url_post, :text_post, :direct_comment, :reply_comment].sample) }

    trait :direct do
      commentable { create(:url_post) }
    end

    trait :reply do
      commentable { build(:direct_comment) }
    end

    factory :reply_comment,  traits: [:reply]
    factory :direct_comment, traits: [:direct]
  end
end
