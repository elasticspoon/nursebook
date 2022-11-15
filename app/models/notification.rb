class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :target
end
