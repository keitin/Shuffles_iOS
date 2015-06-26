class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table :groups_users do |t|
      t.references :user
      t.references :group
      t.timestamps null: false
    end
  end
end
