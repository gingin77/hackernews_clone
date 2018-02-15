require "rails_helper"

feature "Comment on a Post" do
  let(:user) { create(:oliver) }
  let(:post) { create(:url_post,
    title: "Y Combinator Is Launching A “Grad School” For Booming Startups") }

  it "allows authenticated user to comment on a post and see new comment on the parent post show view" do
    submitter = user
    sign_in submitter

    visit post_path((post).id)
    expect(page).to have_http_status(200)
    expect(page).to have_content "Y Combinator Is Launching A “Grad School” For Booming Startups"
    expect(page).to have_content "contributer:	#{post.submitter.name}"
    expect(page).to have_selector(:link_or_button, "Direct Comment On Post")

    fill_in "comment_text", with: "exciting"
    click_on "Direct Comment On Post"

    expect(page).to have_content "Y Combinator Is Launching A “Grad School” For Booming Startups"
    expect(page).to have_content "exciting Reply to #{submitter.name}"
    expect(page).to have_link("Reply to #{submitter.name}",
      href: comment_reply_comment_path(Comment.last.id))
  end

  it "blocks unauthenticated users from submitting comments" do
    visit post_path(post.id)
    expect(page).to have_http_status(200)
    expect(page).to have_content "Y Combinator Is Launching A “Grad School” For Booming Startups"
    expect(page).to have_content "contributer:	#{post.submitter.name}"
    expect(page).to have_selector(:link_or_button, "Direct Comment On Post")

    fill_in "comment_text", with: "exciting"
    click_on "Direct Comment On Post"

    expect(page).to have_content "You need to sign in or sign up before continuing."
    expect(page).to have_content "Sign In"
  end
end
