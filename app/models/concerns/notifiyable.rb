module Notifiyable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :source, dependent: :destroy
    has_many :notified_users, through: :notifications, source: :target, class_name: 'User'
    after_create :notify
  end

  private

  def notify(targets: notification_targets, delay: 0)
    targets&.each do |tar|
      DelayedJob.set(wait: delay)
        .perform_later(Notification, :create, target: tar, content: notification_content, source: self)
    end
  end

  def notification_targets
    raise NotImplementedError
  end

  def notification_content
    raise NotImplementedError
  end
end
