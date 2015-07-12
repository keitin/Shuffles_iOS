class AddLastMessageToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :last_message, :string
  end
end
