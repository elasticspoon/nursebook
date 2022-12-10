# frozen_string_literal: true

class UserSmallComponent < ViewComponent::Base
  attr_reader :user

  delegate :profile, to: :@user
  delegate :first_name, to: :profile
  delegate :last_name, to: :profile

  def initialize(user: nil)
    @user = user
  end

  def name
    "#{first_name} #{last_name}" if @user
  end
end

# rubocop:enable Lint/MissingSuper
