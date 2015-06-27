class Fake < ActiveRecord::Base
  belongs_to :fake_user, class_name: "User"
end
