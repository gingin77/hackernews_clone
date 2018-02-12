class Comment < ApplicationRecord
  belongs_to :submitter, class_name: :User, foreign_key: :user_id
  belongs_to :post

  has_many :reply_comments, class_name: "Comment", foreign_key: :comment_id
  belongs_to :direct_comment, class_name: "Comment", optional: true

  validates :text, presence: { message: 'The comment you submitted was blank' }
end
