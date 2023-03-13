# frozen_string_literal: true

class EmptyPostComponent < ViewComponent::Base
  def post
    Post.new
  end

  def creator_name
    'Loading...'
  end

  def method_missing(symbol, *args)
    return 'Loading...' if PostComponent.method_defined?(symbol, false)

    super
  end

  def respond_to_missing?(symbol, *args)
    return true if PostComponent.method_defined?(symbol, false)

    super
  end
end
