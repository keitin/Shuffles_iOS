json.fakes @fake_users do |fake|
  json.user_name fake.user.name
  json.fake_user_name fake.fake_user.name
end