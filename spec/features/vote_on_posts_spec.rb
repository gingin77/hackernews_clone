require "rails_helper"

feature "Vote on a post" do
  let(:voter) { create(:oliver) }
  let(:url_post) { create(:url_post) }
  let(:text_post) { create(:text_post) }
  let(:up_vote) do
    create :vote, {
      value: 1,
      voter: voter,
      voteable: post
    }
  end

  it "allows authenticated user to vote on a post" do
    sign_in voter
    visit post_path(url_post)
    expect(page).to have_content url_post.title

    visit posts_path
    expect(page).to have_content url_post.title
    expect(page).to have_css "button.up-vote"
    # click_on "up-vote"
  end
end
