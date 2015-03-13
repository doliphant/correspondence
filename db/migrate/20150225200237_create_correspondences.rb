class CreateCorrespondences < ActiveRecord::Migration
  def change
    create_table :correspondences do |t|
      t.string :title
      t.boolean :private, default: false
      t.text :description
      t.integer :creator_id
      t.integer :participant_id

      t.timestamps null: false
    end
  end
end
