class Users::InvitationsController < Devise::InvitationsController
  def update
    logger = Logger.new('log/debug.log')
    logger.info('--------Log for update invitation-------')
    logger.info(params[:user][:invitation_token])
    
    user = User.find(:first, :conditions => ['invitation_token = ?', params[:user][:invitation_token]])
    if !user.blank?
      list_team_member = ListTeamMember.find(:first, :conditions => ['user_id = ? AND invitation_token = ?', user.id, user.invitation_token])
      list_team_member.active = true
      list_team_member.save
      
    end
    super
  end
end
