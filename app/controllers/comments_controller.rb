class CommentsController < ApplicationController
  # include VoteableController
  include HackernewsClone::VoteHelper
  include CommentableController

  before_action :authenticate_user!, only: :create
  before_action :authenticate_to_submit, only: :new

  helper_method :comment

  def new
  end

  def create
    new_comment = current_user.comments.build(comment_params)
    commentable = new_comment.commentable
    if new_comment.save
      redirect_to commentable
    else
      message = new_comment.errors.messages[:text].join(", ")
      if commentable.kind_of?(Post)
        flash[:inline] = message
        redirect_to commentable
      else
        flash.now[:inline] = message
        render :new
      end
    end
  end

  def show
    @comment_presenter = ::CommentPresenter.new(comment, view_context)
  end

  private

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :text,
      :commentable_type,
      :commentable_id
    )
  end
end
