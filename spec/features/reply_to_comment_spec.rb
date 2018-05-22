require "rails_helper"

feature "Reply to a Comment" do
  let(:current_user) { create(:user, :oliver) }
  let(:direct_comment) do
    create :direct_comment,
    text: "some snarky comment"
  end
  let(:parent_post) { direct_comment.commentable }

  it "allows authenticated user to submit a reply comment and get redirected to parent comment show view" do
    sign_in current_user

    visit post_path(parent_post)
    expect(page).to have_content parent_post.title
    expect(page).to have_content direct_comment.text
    expect(page).to have_link("Reply",
      href: comment_reply_comment_path(direct_comment))
    click_on "Reply"

    expect(page).to have_content direct_comment.text
    expect(page).to have_selector(:link_or_button, 'Submit Reply')
    expect(page).not_to have_link("Reply to #{direct_comment.submitter.name}",
      href: comment_reply_comment_path(direct_comment))

    fill_in "comment_text", with: "I completely agree"
    click_on "Reply"

    expect(page).to have_content direct_comment.text
    expect(page).to have_content "I completely agree Reply to #{current_user.name}"
    expect(page).not_to have_selector(:link_or_button, 'Submit Reply')
    expect(page).not_to have_content parent_post.title
  end

  it "blocks unauthenticated users from submitting replies" do
    visit post_path(parent_post)
    expect(page).to have_content parent_post.title

    expect(page).to have_content direct_comment.text
    expect(page).not_to have_link("Reply",
      href: comment_reply_comment_path(direct_comment))

    visit comment_reply_comment_path(direct_comment)
    expect(page).to have_content "You must be logged in to submit a post or comment"
    expect(page).to have_content "Sign In"
  end
end
