class LikedPost < ApplicationRecord
  include Notifiyable

  belongs_to :user, counter_cache: :liked_posts_cache
  belongs_to :post, counter_cache: :likes_count

  private

  def content
    "#{user.email} liked your post"
  end

  def notification_targets
    [post.creator]
  end
end
