class CommentsController < ApplicationController
  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create
  before_action :parent, only: :create

  helper_method :new_comment, :parent, :comment

  def new
  end

  def create
    @comment = @parent.comments.build(comment_params)
    if @comment.save
      redirect_to @parent
    elsif !@comment.save
      flash[:inline] = @comment.errors.messages[:text].join(", ")
      if @parent.kind_of?(Post)
        redirect_to @parent
      elsif @parent.kind_of?(Comment)
        redirect_to comment_reply_comment_path(@parent)
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
