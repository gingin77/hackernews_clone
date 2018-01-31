class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @submission = Submission.new
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
      redirect_to submission_path(@submission.id)
    else
      flash[:danger] = @submission.errors.messages
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
