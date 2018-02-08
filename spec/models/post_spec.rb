require "rails_helper"

RSpec.describe Post, :type => :model do
  it "creates a text post" do
    post = Post.new( text: "I'm a new text post", submitter: create(:user_a) )
    post.save

    expect(post.persisted?).to eq(true)
  end

  it "will not create a post without a submitter" do
    post = Post.new( text: "I'm a new text post", submitter: nil )
    post.save

    expect(post.persisted?).to eq(false)
  end

  it "creates a url post" do
    post = Post.new(
      url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
      title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?",
      submitter: create(:user_b) )
    post.save

    expect(post.persisted?).to eq(true)
  end

  it "finds a text post with a url to be invalid" do
    post = build(:text_post, url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia")
    post.save

    expect(post.persisted?).to eq(true)
  end

  it "finds a text post with a title to be invalid" do
    post = build(:text_post, title: "A title")
    post.save

    expect(post.persisted?).to eq(true)
  end

end
