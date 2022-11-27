class FixLikedPostAndLikeCommentsColumnsNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :liked_posts, :post_id, :target_id
    rename_column :liked_comments, :comment_id, :target_id
  end
end
