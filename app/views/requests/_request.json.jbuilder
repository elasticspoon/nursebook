json.extract! request, :id, :accepted, :sender_id, :receiver_id, :created_at, :updated_at
json.url request_url(request, format: :json)
