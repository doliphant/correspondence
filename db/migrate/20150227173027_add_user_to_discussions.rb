class AddUserToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :creator_id, :integer
    add_column :discussions, :participant_id, :integer

    add_index :discussions, :creator_id
    add_index :discussions, :participant_id
  end
end
