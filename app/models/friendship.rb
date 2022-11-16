class Friendship < ApplicationRecord
  include Notifiyable

  belongs_to :user_one, class_name: 'User', counter_cache: :friends_cache
  belongs_to :user_two, class_name: 'User', counter_cache: :friends_cache

  validate :check_existing_friendships, :check_existing_requests, on: :create

  private

  def check_existing_friendships
    friendship = Friendship.where(
      user_one:,
      user_two:
    ).or(Friendship.where(
           user_one: user_two,
           user_two: user_one
         )).take

    errors.add(:base, "Friendship already exists: #{friendship.inspect}") if friendship
  end

  def check_existing_requests
    request = Request.where(
      sender: user_two,
      receiver: user_one
    ).or(Request.where(
           sender: user_one,
           receiver: user_two
         )).take

    errors.add(:base, "Request already exists: #{request.inspect}") if request
  end

  def notification_targets
    [user_one, user_two]
  end

  def content
    "#{user_one.email} and #{user_two.email} are now friends."
  end
end
