class ProfileNameSetOn < ActiveRecord::Migration
  def change
    add_column :users, :profile_name_set_on, :datetime
  end
 
end
