require "rails_helper"

feature "Vote on a post" do
  let(:voter) { create(:oliver) }
  let(:url_post) { create(:url_post) }
  let(:text_post) { create(:text_post) }
  # let(:up_vote) do
  #   create :vote, {
  #     value: 1,
  #     voter: voter,
  #     voteable: url_post
  #   }
  # end

  it "allows authenticated user to vote on a post once" do
    sign_in voter
    visit post_path(url_post)
    expect(page).to have_content url_post.title

    visit posts_path
    expect(page).to have_content url_post.title

    expect(page).to have_button("up", class: "clickable")
    expect(page).to have_button("down", class: "clickable")
    expect(page).to have_css "i.not-clickable, i.fa-times-circle"

    click_button "up"

    expect(page).to have_button("up", class: "not-clickable")
    expect(page).to have_button("down", class: "clickable")
    expect(page).to have_link("delete", href: "/votes/#{Vote.last.id}")
    expect(page).to have_css "i.clickable, i.fa-times-circle"
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
