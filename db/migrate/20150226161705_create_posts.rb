class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.references :correspondence, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :correspondences
  end
end
