class VotesController < ApplicationController
  helper_method :vote, :new_vote

  def index
    @votes = Vote.all
  end

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

  def destroy
    if vote.destroy
      flash[alert] = "Your vote was deleted"
    else
      flash[alert] = "The vote can't be deleted"
    end
    redirect_to @posts
  end

  private

  def new_vote
    @vote = Vote.new
  end

  def parent
    @parent = @vote.votable
  end

  def vote
    @vote ||= Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:voteable_type, :voteable_id, :value)
  end
end
