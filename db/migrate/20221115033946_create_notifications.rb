class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :content
      t.references :source, polymorphic: true, null: false
      t.references :target, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
