class AddPaidFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paid_user, :boolean, :default => false
  end
end
