class Api::TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :create]

  def index
    @tweets = Tweet.fetch_tweets(tweets_params)
    @group = Group.search(params["name"], params["password"])
  end

  def create
    Tweet.create_tweet(create_params)
    Group.search_group(group_params).update(last_message: params[:text])
  end

  private
  def tweets_params
    params.permit(:name, :password)
  end

  def create_params
    params.permit(:auth_token, :name, :password, :text)
  end

  def group_params
    params.permit(:name, :password)
  end

end
