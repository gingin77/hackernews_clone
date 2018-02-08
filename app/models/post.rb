class Post < ApplicationRecord
  self.table_name = "submission"

  belongs_to :submitter, class_name: :User, foreign_key: :user_id
end
