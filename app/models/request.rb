class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :outgoing_friend_requests
  belongs_to :receiver,
             class_name: 'User',
             inverse_of: :incoming_friend_requests,
             counter_cache: :friend_requests_cache
end
