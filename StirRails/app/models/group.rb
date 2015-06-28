class Group < ActiveRecord::Base

  # has_many :users, through: :users_group
  has_and_belongs_to_many :users, through: :group_users
  has_many :tweets

  scope :search, ->(name, password) { find_by(name: name, password: password) }

  #carrierWave
  mount_uploader :avatar, AvatarUploader

  def shuffle_users
    group_user_ids = self.users.map { |user| user.id }
    shuffle_group_user_ids = group_user_ids.shuffle

    pare_ids = []
    group_user_ids.zip(shuffle_group_user_ids).each do |id, shuffle_id|
      pare_ids << [id, shuffle_id]
    end

    pare_ids.each do |pare_id|
      Fake.create(user_id: pare_id.first, fake_user_id: pare_id.second)
    end
  end

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
