class CreateGroupUser < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.references :user
      t.references :group
    end
  end
end
