class AddIndexToListMembers < ActiveRecord::Migration
  def change
    add_index :list_team_members, :user_id
    add_index :list_team_members, :list_id
    add_index :list_team_members, :active
  end
end
