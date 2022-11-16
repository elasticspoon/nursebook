class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :outgoing_friend_requests
  belongs_to :receiver,
             class_name: 'User',
             inverse_of: :incoming_friend_requests,
             counter_cache: :friend_requests_cache

  validates :accepted, inclusion: { in: [false] }, on: :create

  validate :check_existing_requests, :check_existing_friendships, on: :create

  after_update :check_for_acceptance

  private

  def check_existing_requests
    request = Request.where(sender:, receiver:).or(Request.where(sender: receiver, receiver: sender)).take

    errors.add(:base, "Request already exists: #{request.inspect}") if request
  end

  def check_existing_friendships
    friendship = Friendship.where(
      user_one: sender,
      user_two: receiver
    ).or(Friendship.where(
           user_one: receiver,
           user_two: sender
         )).take

    errors.add(:base, "Friendship already exists: #{friendship.inspect}") if friendship
  end

  def check_for_acceptance
    create_friendship if accepted && destroy && destroyed?
  end

  def create_friendship
    Friendship.create(user_one: sender, user_two: receiver)
  end
end
