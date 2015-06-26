class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer :user_id
      t.integer :group_id
      t.timestamps null: false
    end
  end
end
