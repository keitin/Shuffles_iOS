class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :update]

  def index

  end

  def create
    @user = User.new(create_params)
    @error_message = []
    unless @user.save
       @error_message = [@user.errors.full_messages].compact
    end
  end

  def update
    user = User.by_auth_token(auth_token_params[:auth_token])
    user.update(update_params)
    @user = User.by_auth_token(auth_token_params[:auth_token])
  end

  def fetch_user
    @user = User.by_auth_token(auth_token_params[:auth_token])
  end

  private
  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
    params.permit(:name, :avatar)
  end

  def auth_token_params
    params.permit(:auth_token)
  end

end
