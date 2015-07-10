json.tweets @tweets do |tweet|
  json.text tweet.text
  json.avatar tweet.user.avatar
  json.user_name @group.fetch_group_fake_user(tweet.user.id).user.name
  json.fake_user_name @group.fetch_group_fake_user(tweet.user.id).fake_user.name
end