# module VoteableController
#   extend ActiveSupport::Concern
#
#   def self.included(base)
#     base.helper_method :parents_vote
#   end
#
#   def parents_vote(parent)
#     @vote = Vote.find_by(user_id: current_user, voteable_id: parent)
#   end
# end
