module ApplicationHelper
  def comments_index_turbo_id(post_id)
    if post_id
      "comments_list_post_#{post_id}"
    else
      'comments_list'
    end
  end

  def like_button_id(post)
    dom_id(post, :like_button)
  end

  def build_new_comment_path(parent, current_user)
    new_comment_path(comment: { parent_id: parent.id, parent_type: parent.class.name, user_id: current_user&.id })
  end
end
