# rubocop:disable Lint/MissingSuper
# frozen_string_literal: true

class PostComponent < ViewComponent::Base
  include ApplicationHelper

  delegate :creator, to: :@post
  delegate :profile, to: :creator
  delegate :first_name, to: :profile
  delegate :last_name, to: :profile

  def initialize(post:, current_user: nil)
    @post = post
    @current_user = current_user
  end

  def creator_name
    "#{first_name} #{last_name}"
  end

  def post_age
    time_ago_in_words(@post.created_at)
  end

  def liked
    @post.liked_by?(@current_user)
  end

  def likes_num
    @post.likers.size
  end

  def likes_count
    content_tag(
      :span,
      class: "post__social-data #{'post__social-data--hidden' if likes_num.zero?}",
      data:  { post_target: 'likeCount' }
    ) { likes_text }
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

  def render_like_button
    render(LikeButtonComponent.new(like_object: LikedPost.new(target: @post)))
  end

  private

  def likes_text
    if liked && likes_num > 1
      "You and #{likes_num - 1} others"
    elsif liked && likes_num <= 1
      @current_user.name
    elsif !liked && likes_num > 0
      likes_num.to_s
    else
      ''
    end
  end
end

# rubocop:enable Lint/MissingSuper