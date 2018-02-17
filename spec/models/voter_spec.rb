require "rails_helper"

RSpec.describe Vote, type: :model do
  subject { create(:vote) }

  it { is_expected.to belong_to(:voteable) }
  it { is_expected.to belong_to(:voter) }
  it { is_expected.to have_attribute(:value) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:voteable_id, :voteable_type) }
  it { is_expected.to validate_numericality_of(:value) }
  it { is_expected.to allow_value(1).for(:value) }
  it { is_expected.to allow_value(-1).for(:value) }
  it { is_expected.not_to allow_value(2).for(:value) }
  it { is_expected.not_to allow_value(-2).for(:value) }
  it { is_expected.not_to allow_value(0.9999).for(:value) }
  it { is_expected.not_to allow_value(0.9999).for(:value) }
end
