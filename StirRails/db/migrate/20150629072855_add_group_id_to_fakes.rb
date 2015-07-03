class AddGroupIdToFakes < ActiveRecord::Migration
  def change
    add_column :fakes, :group_id, :integer
  end
end
