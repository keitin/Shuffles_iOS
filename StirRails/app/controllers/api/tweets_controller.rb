class Api::TweetsController < ApplicationController

  def index
    @tweets = Tweet.fetch_tweets(tweets_params)
  end

  private
  def tweets_params
    params.permit(:auth_token, :group_name, :group_pass)
  end

end
