class RegistrationsController < Devise::RegistrationsController
  before_filter :load_invitation, :only => [:update_password, :edit_password]
  (skip_before_filter :authenticate_user!, :only => [:update_password, :edit_password]) unless @invitation.blank?
  
  def edit_password
    
  end
  
  def update_password
    @user.update_attributes(params[:user])
    sign_in(:user, @user) unless current_user
    @invitation.accept(@user)  unless @invitation.blank?
    redirect_to list_path(@invitation.invited_for), notice: "Invitation is successfully accepted."
  end
  
  def create
    #If the user is already invited(created with empty password), update it. Users are allowed to sign-up directly, which will override the record created by invitation.
    user = User.find_by_email(params[:user][:email])
    invitation = Invitation.where(:email => params[:user][:email]).where("accepted_at is not ?", nil).first
    
    if !user.blank? && !invitation.blank? && user.encrypted_password.blank?
      if user.update_attributes(params[:user]) 
        #User need to reconfirm in this case, as he signed-up directly, despite invitation.
        user.generate_new_confirmation_token()
        user.send_confirmation_instructions 
        
        sign_in(user)
        redirect_to after_sign_up_path_for(user)
      else
        clean_up_passwords user
        self.resource = user
        respond_with user
      end
    else
      build_resource #from devise
      if resource.save
        sign_in(resource)
        redirect_to after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        respond_with resource
      end
      
    end
    
  end

  def confirmation_message
  
  end
  
  def valid_token?
    @invitation = Invitation.find_by_token(params[:token]) unless params[:token].blank?
    @invitation.blank?
  end
  
  protected
  
  def load_invitation
    @invitation = Invitation.find_by_token(params[:token]) unless params[:token].blank?
    @user = User.find_by_email(@invitation.email)
  end
  
  #This will redirect the user to a custom page after sign-up(before confirmation)
  def after_sign_up_path_for(resource)
    confirmation_message_path unless resource.confirmed?
  end
end
