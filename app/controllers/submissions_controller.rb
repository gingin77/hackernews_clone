class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :create_comment]
  before_action :authenticate_to_submit, only: :new

  helper_method :posts, :post, :new_post, :new_comment

  def new
  end

  def show
  end

  def index
  end

  def create
    @post = Submission.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:alert] = "Your submission was saved"
      redirect_to submission_path(@post.id)
    else
      flash[:alert] = @post.errors.messages
      redirect_to new_submission_path
    end
  end

  def create_comment
    @comment = Submission.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = parent_post_id
    if @comment.save
      flash[:alert] = "Your submission was saved"
      redirect_to submission_path(@comment.post_id)
    else
      flash[:alert] = @comment.errors.messages
      redirect_to submission_path(parent_post_id)
    end
  end

  private

  def authenticate_to_submit
    if !user_signed_in?
      flash[:alert] = "You must be logged in to submit a post"
      redirect_to new_user_session_path
    end
  end

  def posts
    @posts = Submission.where(post_id: nil)
  end

  def post
    @post = Submission.find(params[:id])
  end

  def new_post
    @post = Submission.new
  end

  def new_comment
    @comment = Submission.new
  end

  def post_params
    params.require(:submission).permit(:title, :url, :text)
  end

  def comment_params
    params.require(:submission).permit(:text)
  end

  def parent_post_id
    params[:submission_id]
  end
end
