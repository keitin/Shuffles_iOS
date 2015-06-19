class Group < ActiveRecord::Base

  belongs_to :user

  scope :search, ->(name, password) { find_by(name: name, password: password) }

  def self.create_my_group(params)
    auth_token = params[:auth_token]
    user = User.by_auth_token(auth_token)
    Group.create(name: params[:name], password: params[:password], user_id: user.id )
  end

  def self.fetch_my_groups(params)
    auth_token = params[:auth_token]
    user = User.by_auth_token(auth_token)
    return user.groups
  end

  def self.search_group(params)
    search(params[:name], params[:password])
  end

end
