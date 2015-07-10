class Api::FakesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:checked]

  def checked
    user = User.by_auth_token(auth_token_params[:auth_token])
    group = Group.search_group(group_params)
    Fake.checked(user, group)
  end


  private
  def auth_token_params
    params.permit(:auth_token)
  end

  def group_params
    params.permit(:name, :password)
  end

end
