require "rails_helper"

RSpec.describe Comment, type: :model do
  it "creates a comment by a submitter" do
    comment = Comment.new(text: "that post is awesome!!!!", post: create(:text_post), submitter: create(:user_b))
    comment.save

    expect(comment.persisted?).to eq(true)
  end

  it "can't create a direct comment without a parent post" do
    comment = build(:direct_comment, post: nil)
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

  it "will not create a comment with a url link" do
    comment = build(:direct_comment, url: "https://www.fastcompany.com/40524163/y-combinator-is-launching-a-grad-school-for-booming-startups")
    comment.save

    expect(comment.persisted?).to eq(false)
  end

  it "will not create a comment with a title" do
    comment = build(:direct_comment, title: "Top 10 Languages Your Agency Needs to Know How to Use")
    comment.save

    expect(comment.persisted?).to eq(false)
  end
end
