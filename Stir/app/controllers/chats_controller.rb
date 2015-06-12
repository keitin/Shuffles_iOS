class ChatsController < ApplicationController

  def create
    Chat.create(create_params)
    redirect_to '/' and return
  end

  private
  def create_params
    params.require(:chat).permit(:text).merge(user_id: current_user.id, group_id: current_user.group.id)
  end
end
