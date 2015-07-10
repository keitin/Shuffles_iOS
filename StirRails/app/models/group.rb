class Group < ActiveRecord::Base

  # has_many :users, through: :users_group
  has_and_belongs_to_many :users, through: :group_users
  has_many :tweets
  has_many :fakes

  scope :search, ->(name, password) { find_by(name: name, password: password) }
  scope :first_group, -> { find_by(id: [1, 2, 3, 4, 5]) }
  #carrierWave
  mount_uploader :avatar, AvatarUploader


  def fetch_group_fake_user(user_id)
    fakes.find_by(user_id: user_id)
  end


  def self.all_group_user_shuffle
    p "++++++++++++++++++++++++++"
    groups = Group.all
    groups.each do |group|
      group.shuffle_users
    end
    Fake.update_all(is_checked: false)
  end


  def shuffle_users
    group_user_ids = self.users.map { |user| user.id }
    shuffle_group_user_ids = group_user_ids.shuffle

    pare_ids = []
    group_user_ids.zip(shuffle_group_user_ids).each do |id, shuffle_id|
      pare_ids << [id, shuffle_id]
    end

    pare_ids.each do |pare_id|
      fake = Fake.where(user_id: pare_id.first, group_id: self.id).first_or_initialize
      fake.fake_user_id = pare_id.second
      fake.save
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
