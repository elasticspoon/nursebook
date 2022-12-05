# frozen_string_literal: true

class PostContentComponent < ViewComponent::Base
  def initialize(images: nil, body: nil, editing: false)
    @images = images
    @body = body
    @editing = editing
  end
end
