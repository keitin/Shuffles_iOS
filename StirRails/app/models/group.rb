class Group < ActiveRecord::Base

  # has_many :users, through: :users_group
  has_and_belongs_to_many :users, through: :group_users

  scope :search, ->(name, password) { find_by(name: name, password: password) }

  #carrierWave
  mount_uploader :avatar, AvatarUploader

  def self.create_my_group(params)
    auth_token = params[:auth_token]
    user = User.by_auth_token(auth_token)
    Group.create(name: params[:name], password: params[:password], avatar: params[:avatar], user_id: user.id )
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
