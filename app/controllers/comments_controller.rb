class CommentsController < ApplicationController
  include HackernewsClone::VoteHelper

  before_action :authenticate_user!, only: :create
  before_action :authenticate_to_submit, only: :new

  helper_method :new_comment, :commentable, :comment

  def new
  end

  def create
    @new_comment = current_user.comments.build(comment_params)
    commentable = @new_comment.commentable
    if @new_comment.save
      redirect_to commentable
    else
      message = @new_comment.errors.messages[:text].join(", ")
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

  def commentable
    @commentable ||= if params[:comment_id]
      Comment.find(params[:comment_id])
    else
      Comment.find(params[:comment][:commentable_id])
    end
  end

  def new_comment
    @new_comment ||= commentable.comments.build
  end

  def comment_params
    params.require(:comment).permit(
      :text,
      :commentable_type,
      :commentable_id
    )
  end
end
