require "rails_helper"

feature "Vote on a post" do
  let(:voter) { create(:oliver) }
  let!(:url_post) { create(:url_post) }

  before :each do
    sign_in voter
    visit posts_path
    expect(page).to have_content url_post.title
  end

  def posts_vote_count
    find("div.vote_count").text.to_i
  end

  def cast_up_vote
    click_button "up"
  end

  def cancel_vote
    click_link "delete"
  end

  it "allows authenticated user to vote up on a post once" do
    expect(posts_vote_count).to eq(0)
    expect(page).to have_button("up", class: "clickable")
    expect(page).to have_button("down", class: "clickable")
    expect(page).to have_css "i.not-clickable, i.fa-times-circle"

    cast_up_vote

    expect(posts_vote_count).to eq(1)
    expect(page).to have_css "i.not-clickable, i.fa-chevron-circle-up"
    expect(page).to have_button("down", class: "clickable")

    expect(page).to have_css "i.clickable, i.fa-times-circle"
    expect(page).to have_link("delete", href: "/votes/#{Vote.last.id}")
  end

  it "allows voter to cancel their vote" do
    cast_up_vote
    expect(posts_vote_count).to eq(1)

    cancel_vote
    expect(posts_vote_count).to eq(0)
    expect(page).to have_button("up", class: "clickable")
    expect(page).to have_button("down", class: "clickable")

    expect(page).to have_css "i.not-clickable, i.fa-times-circle"
  end
end
