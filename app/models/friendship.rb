class Friendship < ApplicationRecord
  belongs_to :user_one, class_name: 'User', counter_cache: :friends_cache
  belongs_to :user_two, class_name: 'User', counter_cache: :friends_cache
end
