class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  before_create :generate_access_token



  private

    def generate_access_token
      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end
end
