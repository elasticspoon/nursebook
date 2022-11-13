class Post < ApplicationRecord
  belongs_to :creator,
             class_name: 'User',
             foreign_key: 'user_id',
             inverse_of: :posts,
             counter_cache: :posts_cache,
             optional: true

  validates :creator, presence: true, on: :create
end
