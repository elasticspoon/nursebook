class LikedComment < ApplicationRecord
  include Notifiyable

  belongs_to :target, counter_cache: :likes_count, class_name: 'Comment'
  belongs_to :user, counter_cache: :liked_comments_cache

  private

  def notification_content
    "#{user.email} liked your comment"
  end

  def notification_targets
    [target.creator]
  end
end
