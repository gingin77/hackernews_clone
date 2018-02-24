require "rails_helper"

RSpec.describe Post, type: :model do
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }

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

  let!(:url_post) { create(:url_post) }
  let!(:alices_vote) { create(:vote, :alice, voteable: url_post)}
  let!(:olivers_vote) { create(:vote, :oliver, voteable: url_post)}

  it "destroys child votes when a parent post is deleted" do
    expect{ url_post.destroy }.to change { Vote.count}.by(-2)
  end

  describe ".type" do
    let(:text_post) { build(:text_post) }
    let(:url_post) { build(:url_post) }

    it "returns 'text' when the post is a 'text_post'" do
      expect(text_post.type).to eq("text")
    end

    it "returns 'url' when the post is a 'url_post'" do
      expect(url_post.type).to eq("url")
    end
  end
end
