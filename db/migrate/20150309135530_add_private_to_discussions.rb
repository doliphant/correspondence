class AddPrivateToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :private, :boolean, default: false
  end
end
