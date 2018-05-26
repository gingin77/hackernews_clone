require "rails_helper"

feature "Vote on a post" do
  let(:voter)     { create(:user, :oliver) }
  let!(:url_post) { create(:url_post) }

  def posts_vote_score
    find("div.vote_count").text.to_i
  end

  def cast_up_vote
    click_button "up"
  end

  def cast_down_vote
    click_button "down"
  end

  def cancel_vote
    click_link "delete"
  end

  before do
    voter.confirm
    sign_in voter
    visit posts_path
    expect(page).to have_content url_post.title.truncate(60, {separator: " "})
  end

  it "allows authenticated user to vote up on a post once" do
    expect(posts_vote_score).to eq(0)
    expect(page).to have_button("up", class: "clickable")
    expect(page).to have_button("down", class: "clickable")
    expect(page).to have_css "i.not-clickable, i.fa-times-circle"

    cast_up_vote

    expect(posts_vote_score).to eq(1)
    expect(page).to have_css "i.not-clickable, i.fa-chevron-circle-up"
    expect(page).to have_button("down", class: "clickable")

    expect(page).to have_css "i.clickable, i.fa-times-circle"
    expect(page).to have_link("delete", href: "/votes/#{Vote.last.id}")
  end

  it "allows voter to cancel their vote" do
    cast_up_vote
    expect(posts_vote_score).to eq(1)

    cancel_vote
    expect(posts_vote_score).to eq(0)
    expect(page).to have_button("up", class: "clickable")
    expect(page).to have_button("down", class: "clickable")

    expect(page).to have_css "i.not-clickable, i.fa-times-circle"
  end

  it "allows voter to change an up vote to a down vote" do
    cast_up_vote
    expect(posts_vote_score).to eq(1)

    cast_down_vote
    expect(posts_vote_score).to eq(-1)

    expect(page).to have_css "i.not-clickable, i.fa-chevron-circle-down"
    expect(page).to have_button("up", class: "clickable")
    expect(page).to have_css "i.clickable, i.fa-times-circle"
    expect(page).to have_link("delete", href: "/votes/#{Vote.last.id}")
  end
end
