class VotesController < ApplicationController
  before_action :authenticate_user!
  
  helper_method :vote

  def create
    vote = current_user.votes.build(vote_params)
    vote.save
    redirect_back(fallback_location: root_path)
  end

  def update
    vote.value == 1 ? vote.value = -1 : vote.value = 1
    vote.save
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
