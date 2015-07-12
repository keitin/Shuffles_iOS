json.group_name @group.name if @group
json.group_pass @group.password if @group
json.group_image @group.avatar.url if @group