class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :create_comment]
  before_action :authenticate_to_submit, only: :new

  helper_method :post, :posts, :new_submission, :new_comment, :parent_id

  def new
  end

  def show
  end

  def index
  end

  def create
    if !params[:submission][:post_id].present?
      @submission = current_user.submissions.build(post_params)
      if @submission.save
        flash[:alert] = "Your submission was saved"
        redirect_to submission_path(@submission.id)
      else
        render :new
      end
    else
      @comment = current_user.submissions.build(comment_params)
      if @comment.save
        redirect_to submission_path(@comment.post_id)
      else
        flash[:inline] = @comment.errors.full_messages_for(:text).join(", ")
        redirect_to submission_path(@comment.post_id)
      end
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
    @submissions ||= Submission.posts
  end

  def post
    @submission ||= Submission.find(params[:id])
  end

  def new_submission
    @submission ||= Submission.new
  end

  def new_comment
    @comment ||= Submission.new
  end

  def parent_id
    params[:id]
  end

  def post_params
    params.require(:submission).permit(:title, :url, :text)
  end

  def comment_params
    params.require(:submission).permit(:text, :post_id)
  end
end
