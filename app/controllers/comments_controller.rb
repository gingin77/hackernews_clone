class CommentsController < ApplicationController
  include CommentableController

  before_action :authenticate_user!, only: :create
  before_action :authenticate_to_submit, only: :new

  helper_method :comment

  def new
  end

  def create
    new_comment = current_user.comments.build(comment_params)
    commentable = new_comment.commentable
    commentable_owner = User.find(commentable.user_id)

    if new_comment.save
      UserMailer.comment_notification(commentable_owner).deliver_now
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
