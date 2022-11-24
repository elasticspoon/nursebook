# rubocop:disable Lint/MissingSuper
# frozen_string_literal: true

class PostComponent < ViewComponent::Base
  include ApplicationHelper

  delegate :creator, to: :@post
  delegate :profile, to: :creator
  delegate :first_name, to: :profile
  delegate :last_name, to: :profile

  def initialize(post:)
    @post = post
  end

  def creator_name
    "#{first_name} #{last_name}"
  end

  def post_age
    time_ago_in_words(@post.created_at)
  end

  def likes_count
    likes_count = @post.likers.size
    return if likes_count.zero?

    content_tag(:span, class: 'post__social-data') do
      likes_count.to_s
    end
  end

  def comments_count
    comments_count = @post.total_comments.size
    return if comments_count.zero?

    content_tag(:span, class: 'post__social-data') do
      link_to "#{comments_count} Comments",
              comments_path(post_id: @post.id),
              data: { turbo_frame: comments_index_turbo_id(@post.id) }
    end
  end

  def shares_count
    shares_count = rand(0..10)
    return if shares_count.zero?

    content_tag(:span, class: 'post__social-data') do
      "#{shares_count} Shares"
    end
  end

  def post_data
    [post_age]
  end
end

# rubocop:enable Lint/MissingSuper
