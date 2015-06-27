class CreateFakes < ActiveRecord::Migration
  def change
    create_table :fakes do |t|
      t.integer :user_id
      t.integer :fake_user_id
      t.timestamps null: false
    end
  end
end
