class Api::GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :create]

  def index
    @groups = Group.fetch_my_groups(auth_token_params).order("updated_at")
  end

  def create
    group = Group.create(create_params)
    user = User.by_auth_token(auth_token_params[:auth_token])
    Fake.create(user_id: user.id, fake_user_id: user.id, group_id: group.id)
    GroupsUser.create(group_id: group.id, user_id: user.id)
  end

  def search
    @group = Group.search_group(search_params)
  end

  def add_group
    user = User.by_auth_token(auth_token_params[:auth_token])
    group = Group.search_group(search_params)
    if GroupsUser.already_exist?(group, user)
      @error_message = "You aleady join this group"
    else
      Fake.create(user_id: user.id, fake_user_id: user.id, group_id: group.id)
      GroupsUser.create(group_id: group.id, user_id: user.id)
    end
  end

  def fetch_fake_users
    group = Group.search_group(search_params)
    group.shuffle_users
    @fake_users = group.fakes
  end

  def shuffle_users
    group = Group.search_group(search_params)
    group.shuffle_users
  end

  private
  def create_params
    params.permit(:avatar, :name, :password).merge(last_message: "no comment")
  end

  def auth_token_params
    params.permit(:auth_token)
  end

  def search_params
    params.permit(:name, :password)
  end

end
