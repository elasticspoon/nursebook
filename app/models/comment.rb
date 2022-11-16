class Comment < ApplicationRecord
  include Likeable
  include Notifiyable

  belongs_to :creator,
             class_name: 'User',
             foreign_key: 'user_id',
             inverse_of: :comments,
             optional: true,
             counter_cache: :comments_cache
  belongs_to :post, counter_cache: :comments_count
  belongs_to :parent, polymorphic: true, counter_cache: :direct_comments_count

  has_many :comments, as: :parent, dependent: :destroy, inverse_of: :parent, counter_cache: :direct_comments_count

  before_validation :set_post, on: :create

  validates :creator, presence: true, on: :create

  private

  def set_post
    self.post ||= parent.post
  end

  def content
    "#{creator.email} commented on your post"
  end

  def notification_targets
    [post.creator]
  end
end
