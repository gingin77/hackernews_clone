module HackernewsClone
  module VoteHelper
    def self.included(base)
      base.helper_method :new_vote
      base.helper_method :parents_vote
    end

    def new_vote
      @vote = Vote.new
    end

    def parents_vote(parent)
      @vote = Vote.find_by(user_id: current_user, voteable_id: parent.id)
    end
  end
end
