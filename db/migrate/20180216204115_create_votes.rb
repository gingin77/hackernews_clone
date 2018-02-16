class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true, index: true
      t.references :user, null: false
      t.integer :value, null: false
      t.timestamps
    end
  end
end
