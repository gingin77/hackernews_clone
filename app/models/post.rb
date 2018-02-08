class Post < ApplicationRecord
  self.table_name = "submissions"

  belongs_to :submitter, class_name: :User, foreign_key: :user_id
end
