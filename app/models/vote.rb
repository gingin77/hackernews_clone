class Vote < ApplicationRecord
  belongs_to :voter,
             class_name:  :User,
             foreign_key: :user_id,
             dependent:   :destroy

  belongs_to :voteable,
             polymorphic: true,
             dependent:   :destroy

  validates :user_id,
            uniqueness: { scope: [:voteable_id, :voteable_type] }

  validates :value,
            presence: true,
            inclusion: { in: [1, -1] }
end
