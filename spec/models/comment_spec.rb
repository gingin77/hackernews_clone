require "rails_helper"

RSpec.describe Comment, type: :model do
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }

  it do
    should validate_presence_of(:text)
      .with_message("The comment you submitted was blank")
  end

  it "creates a comment by a submitter" do
    comment = Comment.new(
                            text: "that post is awesome!!!!",
                            commentable: create(:text_post),
                            submitter: create(:user, :alice)
                          )
    comment.save

    expect(comment.persisted?).to eq(true)
  end

  it "can't create a direct comment without a parent post" do
    comment = build(:comment, commentable: nil)
    comment.save

    expect(comment.persisted?).to eq(false)
  end

  it "creates a reply comment in response to a parent comment" do
    comment = build(:reply_comment)
    comment.save

    expect(comment.persisted?).to eq(true)
  end

  it "will not create a comment without a submitter" do
    comment = build(:reply_comment, submitter: nil)
    comment.save

    expect(comment.persisted?).to eq(false)
  end

  it "will not create a comment without text content" do
    comment = build(:direct_comment, text: nil)
    comment.save

    expect(comment.persisted?).to eq(false)
  end
end
