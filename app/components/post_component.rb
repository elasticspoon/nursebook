# frozen_string_literal: true

class PostComponent < ViewComponent::Base
  include ApplicationHelper

  attr_reader :post, :current_user

  delegate :creator, to: :post

  def initialize(post: Post.new, current_user: nil, &block)
    @post = post
    @current_user = current_user
    @body = block
  end

  def first_name
    creator&.profile&.first_name
  end

  def last_name
    creator&.profile&.last_name
  end

  def creator_name
    "#{first_name} #{last_name}"
  end

  def post_age
    creation_time = post.created_at

    time_ago_in_words(creation_time) if creation_time
  end

  def liked
    post.liked_by?(current_user)
  end

  def likes_num
    return 0 unless post

    post.likers.size
  end

  def others_likes
    likes_num - (liked ? 1 : 0)
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

    link_to "#{comments_count} Comments",
            comments_path(comment: { parent_id: @post.id, parent_type: 'Post' }),
            class: 'post__social-data',
            data: {
              turbo_frame: dom_id(@post, :comments_list),
              action:      'click->post#toggleCommentList'
            }
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
    render(LikeButtonComponent.new(like_object: Like.new(target: @post)))
  end

  def creator?
    !current_user.nil? && current_user == creator
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
