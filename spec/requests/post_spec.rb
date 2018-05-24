require "rails_helper"

RSpec.describe PostsController do
  describe "Submitting posts" do
    let!(:user) { create(:user, :oliver) }

    context "as logged in user" do
      before {
        user.confirm
        sign_in user
      }

      it "allows a logged in user to create a url post" do
        expect {
          post posts_path, params: { post: {
            title: "Can you believe this??!?!",
            url: "http://www.latimes.com/politics/la-na-pol-essential-washington-updates-epa-bars-ap-cnn-from-summit-on-1527003250-htmlstory.html"} }
        }.to change {
          Post.count
        }.by(1)
      end

      it "allows a logged in user to create a text post" do
        expect {
          post posts_path, params: { post: {
            text: "I wish these weren't the people in charge...."} }
        }.to change {
          Post.count
        }.by(1)
      end
    end
  end
end