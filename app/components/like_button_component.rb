# frozen_string_literal: true

class LikeButtonComponent < ViewComponent::Base
  attr_reader :like_object, :target_id

  def initialize(like_object: Like.new)
    @like_object = like_object
    @target_id = target_id_string
  end

  def button_class
    @like_object.persisted? ? selected_class : default_class
  end

  def append_to_default(data)
    "#{default_class} #{default_class}#{data}"
  end

  def target_id_string
    "like_button_#{like_object.target_type.downcase}_#{like_object.target_id}"
  rescue NoMethodError
    ''
  end

  def like_form
    @like_object.persisted? ? like_form_persisted : like_form_not_persisted
  end

  private

  def selected_class
    "#{default_class} #{default_class}--selected"
  end

  def default_class
    'post__social-button'
  end

  def like_form_not_persisted
    {
      model: @like_object,
      class: default_class,
      data:  { controller: 'button_modifier', post_target: 'likeButton' }
    }
  end

  def like_form_persisted
    {
      model:  @like_object,
      class:  selected_class,
      data:   { controller: 'button_modifier', post_target: 'likeButton' },
      method: :delete
    }
  end
end

# rubocop:enable Lint/MissingSuper
