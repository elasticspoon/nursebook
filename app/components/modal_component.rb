# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(target: nil, &body)
    @body = body
    @target = target
  end
end
