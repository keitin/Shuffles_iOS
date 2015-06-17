class Api::GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :create]

  def index
  end

  def create
    Group.create(create_params)
  end

  private
  def create_params
    params.permit(:name, :password)
  end

end
