require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let!(:user) { create(:user) }

  describe "#comment_notification" do
    let!(:mail) { UserMailer.comment_notification(user) }

    it "notifies post submitter" do
      
    end

    it "conveys message that comment was added to a post" do
      expect(mail.subject).to have_content "Your post on on My Hacker News Lite received a comment"

      expect(mail.body.to_s).to have_content "Your post on on My Hacker News Lite received a comment."
    end
  end
end