class AddColumnDirectCommentsCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :direct_comments_count, :integer
    add_column :posts, :comments_count, :integer
  end
end
