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
            numericality: true,
            inclusion: { in: [1, -1] }
end
