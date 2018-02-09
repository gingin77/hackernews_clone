class CommentsController < ApplicationController
  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create

  # helper_method :comment

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params.merge(submitter: current_user))
    if @comment.save
      redirect_to post_path(@comment.post_id)
    else
      flash[:inline] = @comment.errors.messages[:text].join(", ")
      redirect_to post_path(@comment.post_id)
    end
  end

  private

  # def comment
  #   @comment ||= Comment.find(params[:id])
  # end

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end

  # def parent_post
  #   params[:id]
  # end
end
