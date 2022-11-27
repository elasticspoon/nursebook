class AddDefaultToPostsAndComments < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :direct_comments_count, from: nil, to: 0
    change_column_default :posts, :comments_count, from: nil, to: 0

    change_column_default :comments, :direct_comments_count, from: nil, to: 0

    add_column :comments, :comments_count, :integer, default: 0
  end
end
