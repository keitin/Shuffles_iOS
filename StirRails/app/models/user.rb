class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :email, :password, :password_confirmation

  # has_many :groups, through: :users_group
  has_and_belongs_to_many :groups, through: :group_users
  has_many :tweets

  has_many :fake_users, through: :fakes, source: :fake_user
  has_many :fakes, foreign_key: "user_id"

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  before_create :generate_access_token

  scope :by_auth_token, ->(auth_token) { find_by(auth_token: auth_token) }

  #CarrierWave
  mount_uploader :avatar, AvatarUploader

  private

    def generate_access_token
      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end
end
