require "rails_helper"

RSpec.describe Post, type: :model do
  it "creates a post by a submitter" do
    post = Post.new(text: "I'm a new text post", submitter: create(:oliver))
    post.save

    expect(post.persisted?).to eq(true)
  end

  it "will not create a post without a submitter" do
    post = Post.new( text: "I'm a new text post", submitter: nil )
    post.save

    expect(post.persisted?).to eq(false)
  end

  it "creates a url post with a title by a submitter" do
    post = Post.new(
      url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
      title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?",
      submitter: create(:alice) )
    post.save

    expect(post.persisted?).to eq(true)
  end

  it "finds a url post without a url to be invalid" do
    post = build(:url_post, url: nil)
    post.save

    expect(post.persisted?).to eq(false)
  end

  it "finds a url post without a title to be invalid" do
    post = build(:url_post, title: nil)
    post.save

    expect(post.persisted?).to eq(false)
  end

  it "finds a text post with a url to be invalid" do
    post = build(:text_post, url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia")
    post.save

    expect(post.persisted?).to eq(false)
    expect(post.errors[:base]).to include("You may submit either text content OR a url link, NOT both")
  end

  it "finds a text post with a title to be invalid" do
    post = build(:text_post, title: "A title")
    post.save

    expect(post.persisted?).to eq(false)
    expect(post.errors[:base]).to include("You may submit either text content OR a url link, NOT both")
  end

  it "finds a post without any inputs to be invalid" do
    post = Post.new(title: nil, url: nil, text: nil, submitter: create(:oliver))
    post.save

    expect(post.persisted?).to eq(false)
    expect(post.errors[:base]).to include("You must submit a url link OR text content")
  end
end
