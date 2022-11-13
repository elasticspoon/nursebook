class LikedPost < ApplicationRecord
  belongs_to :user, counter_cache: :liked_posts_cache
  belongs_to :post, counter_cache: :likes_count
end
