class Post < ApplicationRecord
  include Likeable

  belongs_to :creator,
             class_name: 'User',
             foreign_key: 'user_id',
             inverse_of: :posts,
             counter_cache: :posts_cache,
             optional: true

  validates :creator, presence: true, on: :create

  has_many :comments, dependent: :destroy, inverse_of: :parent, counter_cache: :direct_comments_count
  has_many :total_comments, dependent: :destroy, class_name: 'Comment', counter_cache: :comments_count

  has_many_attached :images do |attachable|
    attachable.variant :default, resize_to_limit: [800, 800]
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  def post
    self
  end

  def liked_by?(user)
    likers.include?(user)
  end
end
