class Vote < ApplicationRecord
  belongs_to :voter,
             class_name:  :User,
             foreign_key: :user_id

  belongs_to :voteable,
              polymorphic: true

  validates_uniqueness_of :user_id,
                          scope: [:voteable_id, :voteable_type]

  validates_numericality_of :value, {
                                      only_integer:             true,
                                      greater_than_or_equal_to: -1,
                                      less_than_or_equal_to:    1
                                    }
end
