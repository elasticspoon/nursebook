class LikedComment < ApplicationRecord
  include Notifiyable

  belongs_to :comment, counter_cache: :likes_count
  belongs_to :user, counter_cache: :liked_comments_cache

  private

  def notification_content
    "#{user.email} liked your comment"
  end

  def notification_targets
    [comment.creator]
  end
end
