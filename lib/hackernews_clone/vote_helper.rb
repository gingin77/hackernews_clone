module HackernewsClone
  module VoteHelper
    def self.included(base)
      base.helper_method :new_vote
    end

    def new_vote
      @vote = Vote.new
    end
  end
end
