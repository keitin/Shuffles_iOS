json.groups @groups do |group|
  json.name group.name
  json.password group.password
  json.avatar group.avatar
  json.last_message group.last_message
end