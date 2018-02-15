FactoryBot.define do
  factory :direct_comment, class: Comment do
    submitter { build(:user_b) }
    commentable { build(:url_post) }
    text "Yay, plants!!!!!"
  end

  factory :reply_comment, class: Comment do
    submitter { build(:user_a) }
    commentable { build(:direct_comment) }
    text "That could be useful."
  end
end