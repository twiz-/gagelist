class ListsController < ApplicationController
  #helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :js
  before_filter :find_list, :except => [:index, :new, :create, :completed]
  before_filter :check_create_permission, :only => [:new, :create]
  before_filter :check_permission, :only => [:show, :edit, :destory, :update]
  before_filter :check_ownership, :only => [:remove_membership, :mark_complete, :mark_uncomplete]

  def index
    @private_lists = all_lists.with_one_member
    @lists = all_lists - @private_lists

    lists = @lists.map(&:id)
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient_id: lists).includes(:owner)
    last_viewed = current_user.activity_views.order('viewed_on desc').first
    @activities = @activities.where("created_at > '#{last_viewed.viewed_on}'") unless last_viewed.blank?
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.new(params[:list])
    if @list.save
      @list.list_team_members.create(:user_id => current_user.id, :active => true)
      @private_lists = all_lists.with_one_member
    end
  end

  def show
    @task = @list.tasks.new
    flash[:notice] = 'Project is successfully created.' if params[:new] == 'true'
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
    @list.remove_membership(params[:member_id])
  end

  def mark_complete
    #Don't use update_attributes. security issue. allows mass assignment
    @list.complete = true
    @list.completed_at = Time.now
    @list.save
    @list.create_activity :complete, recipient: @list, owner: current_user
  end

  def mark_uncomplete
    @list.complete = false
    @list.completed_at = nil
    @list.save
  end

  def completed
    @lists = current_user.paricipating_lists.completed
  end

  private

  def find_list
    @list = List.find(params[:id]) unless params[:id].blank?
    @list = List.find(params[:list_id]) if @list.blank?
  end

  def check_create_permission
    #Invited users are not allowed to create new lists
    if current_user.invited_user?
      redirect_to lists_path, :alert => "You don't have permission to do that. This action is notified."  and return
    end
  end

  def check_permission
    unless @list.members.include?(current_user)
      redirect_to lists_path, :alert => "You don't have permission to do that. This action is notified."  and return
    end
  end

  def check_ownership
    #List creator only allowed to remove members
    unless @list.owner?(current_user)
      redirect_to lists_path, :alert => "You don't have permission to do that. This action is notified." and return
    end
  end

  def all_lists
    current_user.paricipating_lists.incomplete
  end
end
