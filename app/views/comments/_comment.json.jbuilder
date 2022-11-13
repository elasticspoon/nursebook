json.extract! comment, :id, :content, :user_id, :post_id, :parent_id, :parent_type, :likes_count, :created_at, :updated_at
json.url comment_url(comment, format: :json)
