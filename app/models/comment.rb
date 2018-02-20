class Comment < ApplicationRecord
  belongs_to :submitter,
             class_name:  :User,
             foreign_key: :user_id,
             dependent:   :destroy

  belongs_to :commentable,
             polymorphic: true,
             dependent:   :destroy

  has_many :comments,
           as: :commentable

  validates :text,
            presence: { message: "The comment you submitted was blank" }
end
