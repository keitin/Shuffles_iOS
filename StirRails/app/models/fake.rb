class Fake < ActiveRecord::Base


  belongs_to :fake_user, class_name: "User"
  belongs_to :group
  belongs_to :user
  belongs_to :fake_user, class_name: "User", foreign_key: "fake_user_id"

end
