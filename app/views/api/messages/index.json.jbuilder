json.array! @messages do |message|
  json.message  message.message
  json.image  message.image
  json.created_at  message.created_at.to_s
  json.user_name  message.user.name
  json.id  message.id
end
