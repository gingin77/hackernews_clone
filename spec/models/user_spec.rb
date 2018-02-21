require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
end
