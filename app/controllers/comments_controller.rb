class CommentsController < ApplicationController
  include HackernewsClone::VoteHelper
  include HackernewsClone::CommentHelper

  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create

  helper_method :comments_parent, :comment

  def new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    parent = @comment.commentable
    if @comment.save
      redirect_to parent
    else
      message = @comment.errors.messages[:text].join(", ")
      if comments_parent.kind_of?(Post)
        flash[:inline] = message
        redirect_to parent
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
    params.require(:comment).permit(:text, :commentable_type, :commentable_id)
  end
end
