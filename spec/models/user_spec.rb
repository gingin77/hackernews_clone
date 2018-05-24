require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:votes).dependent(:destroy) }

  describe "after creation" do
    let!(:user) { build(:user) }

    it "sends a confirmation email" do
      expect{ user.save }.to change(
        Devise.mailer.deliveries, :count
      ).by(1)
    end
  end
end
