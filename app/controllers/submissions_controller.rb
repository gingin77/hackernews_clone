class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :authenticate_to_submit, only: :new

  helper_method :post, :posts, :new_submission, :new_comment, :parent_id

  def new
  end

  def show
  end

  def index
  end

  def create
    @submission = current_user.submissions.build(post_params)
    if @submission.save
      flash[:alert] = "Your submission was saved"
      redirect_to submission_path(@submission.id)
    else
      render :new
    end
  end

  private

  def posts
    @submissions ||= Submission.posts
  end

  def post
    @submission ||= Submission.find(params[:id])
  end

  def new_submission
    @submission ||= Submission.new
  end

  def post_params
    params.require(:submission).permit(:title, :url, :text)
  end
end
