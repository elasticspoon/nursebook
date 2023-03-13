# frozen_string_literal: true

class PostComponent < ViewComponent::Base
  attr_reader :post, :current_user

  delegate :creator, to: :post

  def initialize(post: nil, current_user: nil, &block)
    @post = post
    @current_user = current_user
    @body = block
  end

  def first_name
    creator.profile.first_name
  end

  def last_name
    creator.profile.last_name
  end

  def creator_name
    "#{first_name} #{last_name}"
  end

  def post_age
    time_ago_in_words(post.created_at)
  end

  def liked
    post.liked_by?(current_user)
  end

  def likes_num
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
    comments_count = post.total_comments.size
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
    render(LikeButtonComponent.new(like_object: Like.new(target: post)))
  end

  def creator?
    current_user == creator
  end

  def build_new_comment_path(parent, current_user)
    new_comment_path(comment: { parent_id: parent.id, parent_type: parent.class.name, user_id: current_user&.id })
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

  # def define_nil_methods
  #   %i[
  #     creator
  #     first_name
  #     likes_count
  #     last_name
  #     creator_name
  #     post_age
  #     liked
  #     others_likes
  #     comments_count
  #   ].each do |method|
  #     define_singleton_method(method) { nil }
  #   end

  #   define_singleton_method(:likes_num) { 0 }
  #   define_singleton_method(:dom_id) { |*_args| nil }
  #   define_singleton_method(:edit_post_path) { |*_args, **_kwargs| '' }
  #   define_singleton_method(:index_likers_path) { |*_args, **_kwargs| '' }
  #   define_singleton_method(:index_commentors_path) { |*_args, **_kwargs| '' }
  #   define_singleton_method(:build_new_comment_path) { |*_args, **_kwargs| '' }
  # end
end

# rubocop:enable Lint/MissingSuper
