class CommentsController < ApplicationController
  include HackernewsClone::VoteHelper
  include HackernewsClone::CommentHelper

  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create

  helper_method :comments_parent, :comment

  def new
  end

  def create
    @comment = comments_parent.comments.build(comment_params)
    if @comment.save
      redirect_to comments_parent
    else
      message = @comment.errors.messages[:text].join(", ")
      if comments_parent.kind_of?(Post)
        flash[:inline] = message
        redirect_to comments_parent
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

  def comments_parent
    @parent ||= if params[:comment_id].nil?
      Post.find(params[:post_id])
    else
      Comment.find(params[:comment_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:text).merge(submitter: current_user)
  end
end
