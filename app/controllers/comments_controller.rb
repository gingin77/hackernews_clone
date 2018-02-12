class CommentsController < ApplicationController
  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create

  helper_method :parent_comment, :parent_post, :comment, :direct_comments_on_post

  def new
  end

  def create
    @comment = Comment.new(comment_params.merge(submitter: current_user))
    unless @comment.save
      flash[:inline] = @comment.errors.messages[:text].join(", ")
    end
    redirect_to post_path(@comment.post_id)
  end

  private

  def comment
    @comment = Comment.new
  end

  def comment_params
    params.require(:comment).permit(:text, :post_id, :comment_id)
  end

  def parent_comment
    @parent_comment ||= Comment.find(params[:comment_id])
  end

  def parent_post
    @post ||= Post.find(params[:post_id])
  end
end
