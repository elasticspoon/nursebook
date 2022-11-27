class AddIndexToLikedPostsOnPostIdAndUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :liked_posts, %i[post_id user_id], unique: true
    add_index :liked_comments, %i[comment_id user_id], unique: true
  end
end
