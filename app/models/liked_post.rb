class LikedPost < ApplicationRecord
  include Notifiyable

  belongs_to :target, counter_cache: :likes_count, class_name: 'Post'
  belongs_to :user, counter_cache: :liked_posts_cache

  private

  def notification_content
    "#{user.email} liked your post"
  end

  def notification_targets
    [target.creator]
  end
end
