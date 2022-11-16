module Notifiyable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :source, dependent: :destroy
    has_many :notified_users, through: :notifications, source: :target, class_name: 'User'
    after_create :notify
  end

  private

  def notify(targets: notification_targets)
    targets&.each do |target|
      Notification.create(target:, source: self, content:)
    end
  end

  def notification_targets
    raise NotImplementedError
  end

  def content
    raise NotImplementedError
  end
end
