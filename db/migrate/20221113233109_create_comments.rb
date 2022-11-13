class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.references :parent, polymorphic: true, null: false
      t.integer :likes_count, default: 0
      t.integer :direct_comments_count, default: 0

      t.timestamps
    end
  end
end
