class VoteButtonPresenter < ApplicationPresenter
  def vote?
    parents_vote.blank?
  end

  def vote_instance(parent, current_user)
    Vote.find_by(user_id: current_user, voteable_id: parent)
  end
end
