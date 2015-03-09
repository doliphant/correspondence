class RemovePublicFromDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :public, :boolean
  end
end
