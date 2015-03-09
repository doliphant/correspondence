class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :correspondence, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :correspondences
    add_foreign_key :comments, :users
  end
end
