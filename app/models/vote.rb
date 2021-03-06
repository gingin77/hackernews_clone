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

  def up_vote?
    vote_type == "up"
  end

  def down_vote?
    vote_type == "down"
  end
end
