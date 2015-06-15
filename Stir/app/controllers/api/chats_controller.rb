class Api::ChatsController < ApplicationController

  def index
    binding.pry
    @chats = current_user.group.chats
  end

end
