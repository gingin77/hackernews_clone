class Vote < ApplicationRecord
  belongs_to :voter,
             class_name:  :User,
             foreign_key: :user_id

  belongs_to :voteable,
             polymorphic: true

  validates :user_id,
            uniqueness: { scope: [:voteable_id, :voteable_type] }

  validates :value,
            presence: true,
            inclusion: { in: [1, -1] }

  def vote_type
    if value == 1
      "up"
    else
      "down"
    end
  end

  def compare_types(b_vote_type)
    if self.vote_type == b_vote_type
      "non-"
    end
  end
end
