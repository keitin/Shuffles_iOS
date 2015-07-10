class Fake < ActiveRecord::Base

  scope :get_fake_user, ->(user_id, group_id) { find_by(user_id: user_id, group_id: group_id) }

  belongs_to :fake_user, class_name: "User"
  belongs_to :group
  belongs_to :user
  belongs_to :fake_user, class_name: "User", foreign_key: "fake_user_id"

  def self.fetch_fake_user(user, group)
    get_fake_user(user.id, group.id).fake_user
  end

  def self.is_checked?(user, group)
    get_fake_user(user.id, group.id).is_checked
  end

  def self.checked(user, group)
    fake = get_fake_user(user.id, group.id)
    fake.update(is_checked: true)
  end


end
