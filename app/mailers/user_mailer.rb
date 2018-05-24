class UserMailer < ApplicationMailer

  def comment_notification(user)
    @user = user
    mail(to: @user.email, subject: "Your post on on My Hacker News Lite received a comment")
  end
end
