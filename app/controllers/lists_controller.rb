class ListsController < ApplicationController
  #helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :js
  
  before_filter :authenticate_user!
  
  def index
    all_lists = current_user.paricipating_lists
    @private_lists = all_lists.with_one_member
    @lists = all_lists - @private_lists
    respond_with({:lists => @lists, :private_lists => @private_lists})
  end
  
  def new
    @list = List.new  
  end
  
  def create
    @list = List.new(params[:list])
    @list.user_id = current_user.id
    if @list.save
      flash[:notice] = "List created"
      list_team_member = ListTeamMember.new({:user_id => current_user.id, :list_id => @list.id, :active => true})
      list_team_member.save
      redirect_to list_url(@list)
    else
      flash[:error] = "Could not post list"
      respond_with(@list, :location => list_url(@list))
    end
  end
  
  def show
    @list = List.find(params[:id])
    @list_team_members = ListTeamMember.where('list_id = ? AND active = ?', @list.id, true)
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def destroy
    @list = List.find(params[:id])
    if @list.destroy
      flash[:notice] = "List Deleted"
      redirect_to lists_url
    else
      flash[:error] = "It just didn't happen for you"
      redirect_to lists_url
    end
  end
  def update
    @list = List.find(params[:id])
    @list.update_attributes(params[:list])  
    respond_with(@list, :location => list_url(@list))
  end
  
  def invite_user
    @list = List.find(params[:list_id])
    user_email = params[:user_email]
    first_name = params[:first_name]
    last_name = params[:last_name]
    
    User.invite!(:email => user_email, :first_name => first_name, :last_name => last_name)
    
    user = User.find(:first, :conditions => ['email = ?', user_email])
    
    list_team_member = ListTeamMember.new({:user_id => user.id, :list_id => @list.id, :active => false, :invitation_token => user.invitation_token})
    list_team_member.save
    
    render :json => {:success => true} 
  end
  
  
end
