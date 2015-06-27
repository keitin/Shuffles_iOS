class Fake < ActiveRecord::Base

  belongs_to :user
  belongs_to :faked_user, :class_name => 'User', :foreign_key => 'fake_user_id'

end
