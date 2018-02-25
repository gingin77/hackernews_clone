class VotesController < ApplicationController
  before_action :authenticate_user!

  helper_method :vote

  def create
    current_user.votes.create(vote_params)
    redirect_back(fallback_location: root_path)
  end

  def update
    vote.update(value: vote_params[:value])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    vote.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def vote
    @vote ||= Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:voteable_type, :voteable_id, :value)
  end
end
