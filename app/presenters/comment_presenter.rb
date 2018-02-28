class CommentPresenter < ApplicationPresenter
  def text
    @model.text
  end

  def submitters_name
    @model.submitter.name
  end

  def submitters_link
    if h.user_signed_in?
      h.comment_reply_comment_path(@model)
    else
      h.user_path(@model.submitter.name)
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
    h.link_to (link_prefix + submitters_name), submitters_link
  end

  def score_present?
    @model&.votes.present?
  end

  def sum
    if score_present?
      @model&.votes.sum(:value)
    end
  end

  def replies?
    @model&.comments.exists?
  end

  def replies
    @model&.comments
  end
end
