class VotesController < ApplicationController
  before_action :authenticate_user!
  helper_method :vote, :parent

  def create
    @vote = current_user.votes.create(vote_params)

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
      format.json { render json: @vote, status: :created }
    end
  end

  def update
    vote.update(value: vote_params[:value])

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
      format.json { render json: vote, status: :updated }
    end
  end

  def destroy
    vote.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
      format.json { render json: vote, status: :deleted }
    end
  end

  private

  def parent
    @parent = @vote.voteable
  end

  def vote
    @vote ||= Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:voteable_type, :voteable_id, :value)
  end
end
