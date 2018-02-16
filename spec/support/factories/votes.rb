FactoryBot.define do
  factory :vote do
    value 1
    voteable { build(:url_post) }
    voter { build(:oliver) }
  end
end
