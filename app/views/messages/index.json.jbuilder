json.array!(@messages) do |message|
  json.extract! message, :id, :message_text, :approved, :times_shown
  json.url message_url(message, format: :json)
end
