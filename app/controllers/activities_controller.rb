class ActivitiesController < ApplicationController
  def index
    user_lists = current_user.paricipating_lists.incomplete.map(&:id)
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient_id: user_lists)
    
    if params[:latest] == 'true'
      last_viewed = current_user.activity_views.order('viewed_on desc').first
      @activities = @activities.where("created_at > '#{last_viewed.viewed_on}'") unless last_viewed.blank?
    end
      
    current_user.activity_views.create(viewed_on: Time.now)
  end
end
