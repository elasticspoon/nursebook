json.extract! friendship, :id, :user_one_id, :user_two_id, :friends_count, :created_at, :updated_at
json.url friendship_url(friendship, format: :json)
