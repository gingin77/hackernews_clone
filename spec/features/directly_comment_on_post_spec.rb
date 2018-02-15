require "rails_helper"

feature "Comment on a Post" do
  let(:submitter) { create(:oliver) }
  let(:post) do
    create :url_post,
      title: "Y Combinator Is Launching A “Grad School” For Booming Startups"
  end

  it "allows authenticated user to comment on a post and see new comment on the parent post show view" do
    sign_in submitter

    visit post_path(post)
    expect(page).to have_content "Y Combinator Is Launching A “Grad School” For Booming Startups"
    expect(page).to have_content "contributer:	#{post.submitter.name}"

    fill_in "comment_text", with: "exciting"
    click_on "Direct Comment On Post"

    expect(page).to have_content "Y Combinator Is Launching A “Grad School” For Booming Startups"
    expect(page).to have_content "exciting Reply to #{submitter.name}"
    expect(page).to have_link("Reply to #{submitter.name}",
      href: comment_reply_comment_path(Comment.last))
  end

  it "blocks unauthenticated users from submitting comments" do
    visit post_path(post)

    expect(page).to have_content "Y Combinator Is Launching A “Grad School” For Booming Startups"
    expect(page).to have_content "contributer:	#{post.submitter.name}"
    expect(page).to have_selector(:link_or_button, "Direct Comment On Post")

    fill_in "comment_text", with: "exciting"
    click_on "Direct Comment On Post"

    expect(page).to have_content "You need to sign in or sign up before continuing."
    expect(page).to have_content "Sign In"
  end
end
