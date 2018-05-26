class CommentPresenter < ApplicationPresenter
  presents :comment
  delegate :text, :id, to: :comment

  def submitter_name
    comment.submitter.name
  end

  def attribution_link
    string, link = if h.user_signed_in?
      ["Reply to #{submitter_name}", h.comment_reply_comment_path(comment)]
    else
      [" - contributed by #{submitter_name}", h.user_path(submitter_name)]
    end

    h.link_to string, link
  end

  def sum
    comment.votes.sum(:value)
  end

  def replies
    comment.comments
  end

  def replies?
    replies.exists?
  end
end
