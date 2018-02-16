class CommentsController < ApplicationController
  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create

  helper_method :new_comment, :parent, :comment

  def new
  end

  def create
    @comment = parent.comments.build(comment_params)
    if @comment.save
      redirect_to parent
    else
      message = @comment.errors.messages[:text].join(", ")
      if parent.kind_of?(Post)
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

  def new_comment
    @comment = Comment.new
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def parent
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
