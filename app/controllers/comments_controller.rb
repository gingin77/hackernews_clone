class CommentsController < ApplicationController
  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create

  helper_method :comment

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to submission_path(@comment.post_id)
    else
      flash[:inline] = @comment.errors.messages[:text].join(", ")
      redirect_to submission_path(@comment.post_id)
    end
  end

  private

  def comment
    @comment = Comment.new
  end

  def comment_params
    params.require(:submission).permit(:text, :post_id)
  end

  def parent_id
    params[:id]
  end
end
