class InvitationMailer < ActionMailer::Base
  default from: "hello@refreshrunner.com"
  
  def invite_to_list(invitation)
    @inviter = invitation.inviter
    @list = invitation.invited_for
    @invitation = invitation
    mail(:to => invitation.email, :subject => "#{invitation.inviter.full_name} - Invitation instructions", from: invitation.inviter.email)
  end
end
