# frozen_string_literal: true

class CommentComponent < ViewComponent::Base
  def initialize(comment:, current_user: nil)
    @comment = comment
    @current_user = current_user
  end

  def comment_age
    time_ago_in_words(@comment.created_at)
  end
end
