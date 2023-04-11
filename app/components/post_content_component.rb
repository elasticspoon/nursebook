# frozen_string_literal: true

class PostContentComponent < ViewComponent::Base
  def initialize(post: nil, editing: false)
    @post = post
    @images = post&.images
    @body = post&.content
    @editing = editing
  end
end
