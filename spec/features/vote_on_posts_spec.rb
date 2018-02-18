require "rails_helper"

feature "Vote on a post" do
  let(:voter) { create(:oliver) }
  let(:url_post) { create(:url_post) }
  let(:text_post) { create(:text_post) }
  let(:up_vote) do
    create :vote, {
      value: 1,
      voter: voter,
      voteable: url_post
    }
  end

  it "allows authenticated user to vote on a post" do
    sign_in voter
    visit post_path(url_post)
    expect(page).to have_content url_post.title

    visit posts_path
    expect(page).to have_content url_post.title

    expect(page).to have_css "button#up"
    expect(page).to have_css "button#down"
    expect(page).to have_css "a#delete"

    expect(page).to have_link("", :href=>"votes/#{up_vote.id}")
    # expect(page).to have_no_link("Foo", :href=>"google.com")

    # click_on "up-vote"
  end

  it "blocks a user who has voted from casting same vote again" do
    skip
    sign_in voter
    visit post_path(url_post)
    expect(page).to have_content url_post.title

    visit posts_path
    expect(page).to have_content url_post.title

    expect(page).to have_css "button.my-button"
    # click_on "up-vote"
  end
end
