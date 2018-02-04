class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    if user_signed_in?
      @submission = Submission.new
    else
      flash[:alert] = "You must be logged in to submit a post"
      redirect_to new_user_session_path
    end
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def index
    @submissions = Submission.all
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.user_id = current_user.id
    if @submission.save
      flash[:alert] = "Your submission was saved"
      redirect_to submission_path(@submission.id)
    else
      flash[:alert] = @submission.errors.messages
      redirect_to new_submission_path
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:title, :url, :text)
  end

  def submission
    @submission
  end
  helper_method :submission

  def submissions
    @submissions
  end
  helper_method :submissions
end
