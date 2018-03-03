class CommentPresenter < ApplicationPresenter
  presents :comment
  delegate :text, to: :comment

  def submitter_name
    comment.submitter.name
  end

  def submitter_link
    if h.user_signed_in?
      h.comment_reply_comment_path(comment)
    else
      h.user_path(comment.submitter.name)
    end
  end

  def link_prefix
    if h.user_signed_in?
      "Reply to "
    else
      " - contributed by "
    end
  end

  def text_trailer
    h.link_to (link_prefix + submitter_name), submitter_link
  end

  def score_present?
    comment&.votes.present?
  end

  def sum
    if score_present?
      comment&.votes.sum(:value)
    end
  end

  def replies?
    comment&.comments.exists?
  end

  def replies
    comment&.comments
  end
end
