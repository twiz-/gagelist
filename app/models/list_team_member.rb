class ListTeamMember < ActiveRecord::Base
  attr_accessible :list_id, :user_id, :active, :invitation_token
  
  belongs_to :user
  belongs_to :list
end
