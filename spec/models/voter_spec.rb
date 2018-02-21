require "rails_helper"

RSpec.describe Vote, type: :model do
  subject { create(:vote) }
  let(:submitter) { build(:alice) }
  let(:votable) { build(:text_post) }

  it { expect(submitter).to have_many(:votes).dependent(:destroy) }
  it { expect(votable).to have_many(:votes).dependent(:destroy) }

  it { is_expected.to have_attribute(:value) }

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
end
