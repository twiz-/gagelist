class InvitationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:accept]
  
  def create
    @list = List.find(params[:invitation][:invited_for_id]) if params[:invitation][:invited_for_type] == "List"
    @invitation = Invitation.new(params[:invitation])
    @invitation.invited_by = current_user.id
    @invitation.save
  end
 
  def accept
    invitation = Invitation.find_by_token(params[:token])
    unless invitation.blank?   
      user = User.find_by_email(invitation.email)

      unless user.encrypted_password.blank?
        flash[:notice] = 'Invitation is successfully accepted.'
        sign_in(user)
        invitation.accept(user)
        redirect_to lists_path
      else
       redirect_to edit_password_path(:token => invitation.token)
      end  
    else
      flash[:notice] = 'This is not a valid invitation or might have expired already. Please contact the sender.'
      redirect_to root_url
    end
  end
end
