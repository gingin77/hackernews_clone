FactoryBot.define do
  factory :user do
    name "Oliver Sacks"
    sequence(:email) { |n| "olivers#{n}@email.com" }
    password "secret"
  end

  factory :text_submission, class: Submission do
    user { build(:user) }
    text "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
  end

  factory :url_submission, class: Submission do
    user { build(:user) }
    url "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience"
    title "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?"
  end
end
