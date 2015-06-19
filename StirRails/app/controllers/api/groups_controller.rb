class Api::GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :create]

  def index
    @groups = Group.fetch_my_groups(auth_token_params)
  end

  def create
    Group.create_my_group(create_params)
  end

  def search
    @group = Group.search_group(search_params)
  end

  private
  def create_params
    params.permit(:name, :password, :auth_token)
  end

  def auth_token_params
    params.permit(:auth_token)
  end

  def search_params
    params.permit(:name, :password)
  end

end
