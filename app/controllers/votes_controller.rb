class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :request_referrer

  helper_method :vote

  def create
    vote = current_user.votes.build(vote_params)
    vote.save
    redirect_to request_referrer
  end

  def update
    vote.value == 1 ? vote.value = -1 : vote.value = 1
    vote.save
    redirect_to request_referrer
  end

  def destroy
    vote.destroy
    redirect_to request_referrer
  end

  private

  def vote
    @vote ||= Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:voteable_type, :voteable_id, :value)
  end

  def request_referrer
    referrer = Rails.application.routes.recognize_path(request.referrer)
    if "index" == referrer[:action]
      "/#{referrer[:controller]}"
    else
      "/#{referrer[:controller]}/#{referrer[:id]}"
    end
  end
end
