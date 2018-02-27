class CommentPresenter < ApplicationPresenter
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
    h.link_to link_prefix, submitters_link
  end
end
