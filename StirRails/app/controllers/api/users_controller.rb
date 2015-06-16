class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def index

  end

  def create
    @user = User.new(create_params)
    @error_message = []
    unless @user.save
       @error_message = [@user.errors.full_messages].compact
    end
  end

  private
  def create_params
    params.permit(:email, :password, :password_confirmation)
  end

end
