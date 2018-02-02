class AddNullConstraintOnUserToSubmissions < ActiveRecord::Migration[5.1]
  def change
    change_column_null :submissions, :user_id, false
  end
end
