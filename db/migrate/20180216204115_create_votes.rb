class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true
      t.references :user, null: false
      t.integer :value, null: false
      t.timestamps
    end
    add_index :votes, [:user_id, :voteable_id, :voteable_type], unique: true
  end
end
