class Friendship < ApplicationRecord
  belongs_to :user_one
  belongs_to :user_two
end
