# rubocop:disable Lint/MissingSuper
# frozen_string_literal: true

class LikeButtonComponent < ViewComponent::Base
  def initialize(like_object: nil)
    @like_object = like_object
  end

  def selected_class
    "#{default_class} #{default_class}--selected"
  end

  def default_class
    'post__social-button'
  end
end

# rubocop:enable Lint/MissingSuper
