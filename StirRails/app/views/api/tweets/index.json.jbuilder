json.page @page
json.tweets @tweets do |tweet|
  json.text tweet.text
  json.avatar tweet.user.avatar.url
  json.time tweet.created_at
  json.user_name @group.fetch_group_fake_user(tweet.user.id).user.name
  json.fake_user_name @group.fetch_group_fake_user(tweet.user.id).fake_user.name
  json.fake_user_avatar @group.fetch_group_fake_user(tweet.user.id).fake_user.avatar
end