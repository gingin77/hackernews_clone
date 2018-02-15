require "rails_helper"

feature "Display errors when blank comments are submitted" do
  let(:submitter) { create(:oliver) }
  let(:post) { create(:url_post) }
  let(:direct_comment) { create(:direct_comment) }

  it "on a parent post" do
    sign_in submitter

    visit post_path(post)
    expect(page).to have_content post.title

    fill_in "comment_text", with: ""
    click_on "Comment On Post"

    expect(page).to have_content post.title
    expect(page).to have_content "The comment you submitted was blank"
  end

  it "on a parent comment" do
    sign_in submitter

    visit comment_reply_comment_path(direct_comment)
    expect(page).to have_content direct_comment.text

    fill_in "comment_text", with: ""
    click_on "Reply"

    expect(page).to have_content direct_comment.text
    expect(page).to have_content "The comment you submitted was blank"
  end
end
