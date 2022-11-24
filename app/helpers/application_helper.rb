module ApplicationHelper
  def comments_index_turbo_id(post_id)
    if post_id
      "comments_list_post_#{post_id}"
    else
      'comments_list'
    end
  end
end
