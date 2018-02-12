class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :comment
      t.references :post, index: true
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
