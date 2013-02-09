class RemoveUnwantedFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :invitation_token 
    remove_column :users, :invitation_sent_at 
    remove_column :users, :invitation_accepted_at 
    remove_column :users, :invitation_limit 
    remove_column :users, :invited_by_id 
    remove_column :users, :invited_by_type 
    remove_column :list_team_members, :invitation_token 
  end
 
end