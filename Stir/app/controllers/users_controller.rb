class UsersController < ApplicationController

  def show
    @user = User.find(id_params[:id])
    @chats = current_user.chats
  end

  def edit
  end

  def update
    user = User.find(id_params[:id])
    user.update(create_params)
    redirect_to '/' and return
  end

  private
  def id_params
    params.permit(:id)
  end

  def create_params
    params.require(:user).permit(:name)
  end

end
