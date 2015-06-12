class Api::ChatsController < ApplicationController

  def index
    @chats = current_user.group.chats
  end

end
