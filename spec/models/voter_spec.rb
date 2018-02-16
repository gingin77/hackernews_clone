require "rails_helper"

RSpec.describe Vote, type: :model do
  subject { create(:vote) }
  
  it { should belong_to(:voteable) }
  it { should belong_to(:voter) }
  it { should have_attribute(:value) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:voteable_id, :voteable_type) }
end
