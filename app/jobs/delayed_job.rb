class DelayedJob < ApplicationJob
  queue_as :default

  def perform(object, ...)
    # Do something later
    object.public_send(...)
  end
end
