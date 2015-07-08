class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    Group.create(create_params)
  end

  private

  def create_params
    params.require(:group).permit(:avatar)
  end

end
