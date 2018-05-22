require 'rails_helper'

RSpec.describe VotesController do
  let!(:user) { create(:user, :oliver) }

  context "as logged in user" do
    before { sign_in user }

    describe "POST create" do
      let!(:url_post) { create(:url_post) }

      it "allows a logged in user to create an up vote" do
        expect {
          post :create, params: { vote: {
            value: 1,
            voteable_type: "Post",
            voteable_id: url_post.id } }
        }.to change {
          Vote.count
        }.by(1)
      end

      it "allows a logged in user to create a down vote" do
        expect {
          post :create, params: { vote: {
            value: -1,
            voteable_type: "Post",
            voteable_id: url_post.id } }
        }.to change {
          Vote.count
        }.by(1)
      end
    end

    describe "PATCH update" do
      let(:up_vote)   { create(:up_vote, voter: user) }
      let(:down_vote) { create(:down_vote, voter: user) }

      it "allows an up vote to be changed to a down vote" do
        expect {
          patch :update, params: { id: up_vote.id,  vote: { value: -1 } }
          up_vote.reload
        }.to change {
          up_vote.down_vote?
        }.to eq(true)
      end

      it "allows a down vote to be changed to an up vote" do
        expect {
          patch :update, params: { id: down_vote.id,  vote: { value: 1 } }
          down_vote.reload
        }.to change {
          down_vote.up_vote?
        }.to eq(true)
      end
    end
  end
end
