module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :target, dependent: :destroy
    has_many :likers, through: :likes, source: :user, counter_cache: :likes_count
  end
end
