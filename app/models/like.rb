class Like < ApplicationRecord
  include Notifiyable

  belongs_to :user, inverse_of: :user_liked_posts
  belongs_to :target, polymorphic: true, counter_cache: :likes_count

  private

  def notification_content
    "#{user.email} liked your #{target.class.name.downcase}"
  end

  def notification_targets
    [target.creator]
  end
end
