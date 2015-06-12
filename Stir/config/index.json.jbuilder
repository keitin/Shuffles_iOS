json.chats @chats do |chat|
  json.text chat.text
  json.user chat.user
  json.user_name chat.user.name
end
