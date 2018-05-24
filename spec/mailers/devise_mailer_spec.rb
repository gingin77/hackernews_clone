require "rails_helper"

RSpec.describe Devise::Mailer do
  let!(:user)               { create(:user) }
  let!(:confirmation_email) { Devise.mailer.deliveries.last }

	it "sends a confirmation email to correct email with custom text" do
    expect(user.email).to eq confirmation_email.to[0]

    expect(confirmation_email.body.to_s).to have_content "Welcome to my Hacker News - lite, #{ user.name }. Thanks for signing up!"
  end
end