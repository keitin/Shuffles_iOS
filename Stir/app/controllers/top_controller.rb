class TopController < ApplicationController

  def index
    @group = current_user.group
    @chat = Chat.new
    @chats = current_user.group.chats
  end

end
