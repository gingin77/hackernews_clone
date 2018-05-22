require 'rails_helper'

RSpec.describe "Voting" do
  let!(:user)     { create(:user, :oliver) }
  let!(:url_post) { create(:url_post) }
  let!(:up_vote)  { create(:up_vote, voter: user) }
  let(:down_vote) { create(:down_vote, voter: user) }

  before { sign_in user }

  describe "vote creation" do
    it "allows a logged in user to create an up vote" do
      expect {
        post votes_path, params: { vote: {
          value: 1,
          voteable_id: url_post.id,
          voteable_type: "Post"
          } }
      }.to change {
        Vote.count
      }.by(1)
    end

    it "allows a logged in user to create a down vote" do
      expect {
        post votes_path, params: { vote: {
          value: -1,
          voteable_type: "Post",
          voteable_id: url_post.id
          } }
      }.to change {
        Vote.count
      }.by(1)
    end

    describe "vote creation without AJAX" do
      let!(:vote_count_initial) { Vote.count }

      before {
        post votes_path, params: { vote: {
          value: 1,
          voteable_id: url_post.id,
          voteable_type: "Post"
          } }, xhr: false
      }

      it { expect(Vote.count - vote_count_initial).to eq(1) }

      it { expect(response.content_type).to eq("text/html") }

      it { expect(response).to     have_http_status(302) }
      it { expect(response).to_not render_template(partial: "shared/vote/_presenter_index") }
    end

    describe "vote creation with AJAX" do
      let!(:vote_count_initial) { Vote.count }

      before {
        post votes_path, params: { vote: {
          value: 1,
          voteable_id: url_post.id,
          voteable_type: "Post"
          } }, xhr: true
      }

      it { expect(Vote.count - vote_count_initial).to eq(1) }

      it { expect(response.content_type).to eq("text/javascript") }

      it { expect(response).to              have_http_status(200) }
      it { expect(response).to              render_template(partial: "shared/vote/_presenter_index") }
    end

    describe "vote updating" do
      it "allows an up vote to be changed to a down vote" do
        expect {
          patch "/votes/#{up_vote.id}", params: { vote: { value: -1 } }
          up_vote.reload
        }.to change {
          up_vote.down_vote?
        }.to eq(true)
      end

      it "allows a down vote to be changed to a up vote" do
        expect {
          patch "/votes/#{down_vote.id}", params: { vote: { value: 1 } }
          down_vote.reload
        }.to change {
          down_vote.up_vote?
        }.to eq(true)
      end

      describe "vote update via AJAX request" do
        let!(:first_vote) { create(:up_vote, voter: user, voteable: url_post) }

        let!(:initial_score) { url_post.votes.sum(:value) }

        before {
          patch "/votes/#{first_vote.id}", params: { vote: { value: -1 } }, xhr: true
        }

        let!(:score_diff) { url_post.votes.sum(:value) - initial_score }

        it { expect(score_diff).to eq(-2) }

        it { expect(response.content_type).to eq("text/javascript") }
        it { expect(response).to              have_http_status(200) }
        it { expect(response).to              render_template(partial: "shared/vote/_presenter_index") }
      end
    end

    describe "vote deletion" do
      it "allows a logged in user to delete their own vote" do
        expect {
          delete "/votes/#{up_vote.id}", xhr: false
        }.to change {
          Vote.count
        }.by(-1)
      end

      describe "via AJAX request" do
        let!(:first_vote)    { create(:up_vote, voter: user, voteable: url_post) }
        let!(:initial_score) { url_post.votes.sum(:value) }

        before { delete "/votes/#{first_vote.id}", xhr: true }

        let!(:score_diff) { url_post.votes.sum(:value) - initial_score }

        it { expect(score_diff).to eq(-1) }

        it { expect(response.content_type).to eq("text/javascript") }
        it { expect(response).to              have_http_status(200) }
        it { expect(response).to              render_template(partial: "shared/vote/_presenter_index") }
      end
    end
  end
end