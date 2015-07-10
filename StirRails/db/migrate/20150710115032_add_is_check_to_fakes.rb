class AddIsCheckToFakes < ActiveRecord::Migration
  def change
    add_column :fakes, :is_checked, :boolean, :default => false
  end
end
