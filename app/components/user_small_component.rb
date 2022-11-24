# rubocop:disable Lint/MissingSuper
# frozen_string_literal: true

class UserSmallComponent < ViewComponent::Base
  delegate :profile, to: :@user
  delegate :first_name, to: :profile
  delegate :last_name, to: :profile

  def initialize(user:)
    @user = user
  end

  def name
    "#{first_name} #{last_name}"
  end
end

# rubocop:enable Lint/MissingSuper
