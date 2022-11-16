class Notification < ApplicationRecord
  NOTIFICATION_STATES = %w[unread read].freeze

  belongs_to :source, polymorphic: true
  belongs_to :target, class_name: 'User'

  validates :status, inclusion: { in: NOTIFICATION_STATES }
end
