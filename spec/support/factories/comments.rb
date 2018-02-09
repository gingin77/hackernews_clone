FactoryBot.define do
  factory :direct_comment, class: Comment do
    submitter { build(:user_b) }
    post { build(:url_post) }
    text "Yay, plants!!!!!"
  end

  factory :reply_comment, class: Comment do
    submitter { build(:user_a) }
    post { build(:url_post) }
    comment_id { build(:direct_comment).id }
    text "That could be useful."
  end
end
