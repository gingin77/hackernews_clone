class VotesController < ApplicationController
  helper_method :vote

  def create
    @vote = current_user.votes.build(vote_params)
    if @vote.save
      render :show
      # display ^ in vote count tally
      # hide up arrow
      # display an unvote option??
    else
      flash[alert] = @vote.errors.messages[:text].join(", ")
    end
  end

  def show
  end

  private

  def vote
    @vote = Vote.new
  end

  def vote_params
    params.require(:vote).permit(:voteable_type, :voteable_id, :value)
  end
end
