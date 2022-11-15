class RemoveColumnFriendsCountFromFriendship < ActiveRecord::Migration[7.0]
  def change
    remove_column :friendships, :friends_count, :integer
  end
end
