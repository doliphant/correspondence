class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.references :discussion, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :discussions
  end
end