FactoryBot.define do
  factory :text_post, class: Post do
    submitter { build(:oliver) }
    text "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
  end

  factory :url_post, class: Post do
    submitter { build(:alice) }
    url "https://www.fastcompany.com/40524163/y-combinator-is-launching-a-grad-school-for-booming-startups"
    title "Y Combinator Is Launching A “Grad School” For Booming Startups"
  end
end
