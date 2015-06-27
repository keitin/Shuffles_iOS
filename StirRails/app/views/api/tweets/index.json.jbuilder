json.tweets @tweets do |tweet|
  json.text tweet.text
  json.name tweet.user.name
end