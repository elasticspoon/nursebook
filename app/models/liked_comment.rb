class LikedComment < ApplicationRecord
  belongs_to :comment, counter_cache: :likes_count
  belongs_to :user, counter_cache: :liked_comments_cache
end
