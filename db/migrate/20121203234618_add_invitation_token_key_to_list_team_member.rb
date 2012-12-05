class AddInvitationTokenKeyToListTeamMember < ActiveRecord::Migration
  def change
    add_column :list_team_members, :invitation_token, :string
  end
end
