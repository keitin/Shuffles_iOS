class Tweet < ActiveRecord::Base

  belongs_to :user
  belongs_to :tweet

  scope :by_user_id, -> (user_id) { where(user_id: user_id) }
  scope :by_group_id, -> (group_id) { where(group_id: group_id) }

  def self.fetch_tweets(params)
    group = Group.search(params["name"], params["password"])
    group.tweets
  end

  def self.create_tweet(params)
    user = User.by_auth_token(params["auth_token"])
    group = Group.search(params["name"], params["password"])
    params = {text: params["text"], user_id: user.id, group_id: group.id}
    Tweet.create(params)
  end

end
