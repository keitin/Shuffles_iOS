class GroupsUser < ActiveRecord::Base

  def self.already_exist?(group, user)
    GroupsUser.exists?(user_id: user.id, group_id: group.id)
  end


end
