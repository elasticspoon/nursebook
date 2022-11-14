json.extract! liked_comment, :id, :comment_id, :user_id, :created_at, :updated_at
json.url liked_comment_url(liked_comment, format: :json)
