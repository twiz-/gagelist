class ListsController < ApplicationController
  #helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :js
  
  before_filter :authenticate_user!
  before_filter :check_permission, :only => [:new, :create]
  before_filter :find_list, :only => [:edit, :show, :destroy, :update ]
  def index
    all_lists = current_user.paricipating_lists
    @private_lists = all_lists.with_one_member
    @lists = all_lists - @private_lists
  end
  
  def new
    @list = List.new  
  end
  
  def create
    @list = current_user.lists.new(params[:list])
    if @list.save
      flash[:notice] = "List created"
      list_team_member = ListTeamMember.create(:user_id => current_user.id, :list_id => @list.id, :active => true)
      redirect_to list_url(@list)
    else
      flash[:error] = "Could not post list"
      respond_with(@list, :location => list_url(@list))
    end
  end
  
  def show
    @task = @list.tasks.new
    #@list_team_members = ListTeamMember.where('list_id = ? AND active = ?', @list.id, true)
  end
  
  def edit
 
  end
  
  def destroy
    if @list.destroy
      flash[:notice] = "List Deleted"
      redirect_to lists_url
    else
      flash[:error] = "It just didn't happen for you"
      redirect_to lists_url
    end
  end
  
  def update
    @list.update_attributes(params[:list])  
    respond_with(@list, :location => list_url(@list))
  end
  
  def remove_membership
    @list = List.find(params[:list_id])
    membership = @list.list_team_members.where(user_id: params[:member_id]).first
    membership.update_attribute('active', false)
  end
  
  private
  
  def find_list
    @list = List.find(params[:id])
  end
  
  def check_permission
    #Invited users are not allowed to create new lists
    if current_user.invited_user?
      redirect_to lists_path, :alert => "You don't have permission to do that"  and return
    end
  end
  
end
