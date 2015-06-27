class Api::TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :create]


  def index
    @tweets = Tweet.fetch_tweets(tweets_params)
  end

  def create
    Tweet.create_tweet(create_params)
  end

  private
  def tweets_params
    params.permit(:group_name, :group_pass)
  end

  def create_params
    params.permit(:auth_token, :group_name, :group_pass, :text)
  end

end
