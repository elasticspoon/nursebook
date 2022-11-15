json.extract! notification, :id, :content, :source_id, :source_type, :target_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
