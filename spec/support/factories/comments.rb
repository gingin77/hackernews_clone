FactoryBot.define do
  factory :comment do
    text "Yay, plants!!!!!"
    submitter { build(:user, :alice) }
    commentable { create([:url_post, :text_post, :comment].sample) }
  end

  trait :direct do
    commentable { create(:url_post) }
  end

  trait :reply do
    commentable { build(:comment, :direct) }
  end
end
