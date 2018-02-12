class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :text
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
