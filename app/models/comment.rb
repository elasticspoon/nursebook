class Comment < ApplicationRecord
  belongs_to :creator,
             class_name: 'User',
             foreign_key: 'user_id',
             inverse_of: :comments,
             optional: true,
             counter_cache: :comments_cache
  belongs_to :post, counter_cache: :comments_count
  belongs_to :parent, polymorphic: true

  has_many :comments, as: :parent, dependent: :destroy, inverse_of: :parent, counter_cache: :direct_comments_count
end
