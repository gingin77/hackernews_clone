class CommentsController < ApplicationController
  before_action :authenticate_to_submit, only: :new
  before_action :authenticate_user!, only: :create
  before_action :parent, only: :create

  helper_method :new_comment, :parent, :comment

  def new
    session[:return_to] ||= request.referer
  end

  def create
    @comment = @parent.comments.build(comment_params.merge(submitter: current_user))
    unless @comment.save
      flash[:inline] = @comment.errors.messages[:text].join(", ")
    end
    # byebug
    if @comment.commentable_type == "Comment" && !session[:return_to].nil?
      redirect_to session.delete(:return_to)
    elsif @comment.commentable_type == "Comment" && session[:return_to].nil?
      redirect_to comment_path(@comment.id)
    else
      redirect_to post_path(@comment.commentable)
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
    @parent ||= (params[:comment_id].nil?) ? Post.find(params[:post_id]) : Comment.find(params[:comment_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
