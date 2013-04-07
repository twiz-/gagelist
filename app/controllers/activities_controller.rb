class ActivitiesController < ApplicationController
  def index
    all_lists = current_user.paricipating_lists
    private_lists = all_lists.with_one_member
    lists = (all_lists - private_lists).map(&:id)
 
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient_id: lists).includes(:owner)
    
    if params[:latest] == 'true'
      @latest = true
      last_viewed = current_user.activity_views.order('viewed_on desc').first
      @activities = @activities.where("created_at > '#{last_viewed.viewed_on}'") unless last_viewed.blank?
    else
      @activities = @activities.paginate(:per_page => 2, :page => params[:page])    
    end

    current_user.activity_views.create(viewed_on: Time.now)
  end
end
