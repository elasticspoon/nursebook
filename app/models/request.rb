class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :outgoing_friend_requests
  belongs_to :receiver,
             class_name: 'User',
             inverse_of: :incoming_friend_requests,
             counter_cache: :friend_requests_cache

  validates :accepted, inclusion: { in: [false] }

  validate :check_existing_requests, on: :create

  private

  def check_existing_requests
    return unless Request.exists?(sender:, receiver:) || Request.exists?(sender: receiver, receiver: sender)

    errors.add(:base, 'Request already exists')
  end
end
