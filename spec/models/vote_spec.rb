require "rails_helper"

RSpec.describe Vote, type: :model do
  subject { create(:vote) }

  it { is_expected.to have_attribute(:value) }
  it { is_expected.to have_attribute(:user_id) }

  it { is_expected.to belong_to(:voteable) }

  it do
    is_expected.to belong_to(:voter)
      .class_name(User).with_foreign_key(:user_id)
  end

  it do
    is_expected.to validate_uniqueness_of(:user_id)
      .scoped_to(:voteable_id, :voteable_type)
  end

  it { is_expected.to allow_value(1).for(:value) }
  it { is_expected.to allow_value(-1).for(:value) }
  it { is_expected.not_to allow_value(2).for(:value) }
  it { is_expected.not_to allow_value(-2).for(:value) }
  it { is_expected.not_to allow_value(0.9999).for(:value) }
  it { is_expected.not_to allow_value(-0.9999).for(:value) }

  describe "added methods" do
    let!(:up_vote)   { create(:up_vote) }
    let!(:down_vote) { create(:down_vote) }

    describe "#vote_type" do
      it "returns 'up' when value is positiive 1" do
        expect(up_vote.vote_type).to eq("up")
      end

      it "returns 'down' when value is negative 1" do
        expect(down_vote.vote_type).to eq("down")
      end
    end

    describe "#up_vote?" do
      it { expect(up_vote.up_vote?).to   eq(true) }
      it { expect(down_vote.up_vote?).to eq(false) }
    end

    describe "#down_vote?" do
      it { expect(down_vote.down_vote?).to eq(true) }
      it { expect(up_vote.down_vote?).to   eq(false) }
    end
  end
end
