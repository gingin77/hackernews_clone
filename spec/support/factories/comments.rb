FactoryBot.define do
  factory :direct_comment, class: Comment do
    submitter { build(:alice) }
    commentable { create(:url_post) }
    text "Yay, plants!!!!!"
  end

  factory :reply_comment, class: Comment do
    submitter { build(:oliver) }
    commentable { build(:direct_comment) }
    text "That could be useful."
  end
end
