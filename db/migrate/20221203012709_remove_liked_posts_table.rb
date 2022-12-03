class RemoveLikedPostsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :liked_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: { to_table: :posts }
      t.timestamps
      t.index %i[target_id user_id], unique: true
    end

    drop_table :liked_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: { to_table: :comments }
      t.timestamps
      t.index %i[target_id user_id], unique: true
    end
  end
end
