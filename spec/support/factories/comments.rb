FactoryBot.define do
  factory :direct_comment, class: Comment do
    submitter { build(:user_b) }
    post { build(:url_post) }
    text "Yay, plants!!!!!"
  end

  factory :nested_comment, class: Comment do
    submitter { build(:user_a) }
    post { build(:url_post) }
    direct_comment { build(:direct_comment) }
    text "That could be useful."
  end
end
