class CreateLikedComments < ActiveRecord::Migration[7.0]
  def change
    create_table :liked_comments do |t|
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
