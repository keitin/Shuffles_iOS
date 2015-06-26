class Tweet < ActiveRecord::Base

  scope :by_user_id, -> (user_id) { where(user_id: user_id) }
  scope :by_group_id, -> (group_id) { where(group_id: group_id) }

  def self.fetch_tweets(params)
    user = User.by_auth_token(params["auth_token"])
    group = Group.search(params["group_name"], params["group_pass"])
    Tweet.by_user_id(user.id).by_group_id(group.id)
  end

end
