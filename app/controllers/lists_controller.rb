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

  def enable_chat
    @list.chat_enabled = true
    @list.chat_ref = params[:id]
    @list.save
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
    begin
      @list = List.find(params[:id]) unless params[:id].blank?
      @list = List.find(params[:list_id]) if @list.blank?
    rescue
      redirect_to lists_path, :alert => "List not found for that ID." and return
    end
  end

  def check_create_permission
    #Invited users are not allowed to create new lists
    handle_no_access if current_user.invited_user?
  end

  def check_permission
    handle_no_access unless @list.active_members.include?(current_user)
  end

  def check_ownership
    #List creator only allowed to remove members
    handle_no_access unless @list.owner?(current_user)
  end

  def all_lists
    current_user.paricipating_lists.incomplete
  end

  def handle_no_access
    redirect_to lists_path, :alert => "You don't have permission to do that. This action is notified." and return
  end
end
