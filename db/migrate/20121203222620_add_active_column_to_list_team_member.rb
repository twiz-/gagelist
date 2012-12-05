class AddActiveColumnToListTeamMember < ActiveRecord::Migration
  def change
    add_column :list_team_members, :active, :boolean, :default => false, :null => false
  end
end
