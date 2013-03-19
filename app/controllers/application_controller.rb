class ApplicationController < ActionController::Base
  protect_from_forgery     
  before_filter :check_domain
  before_filter :authenticate_user!
  before_filter :trail_ended?
  
  def check_domain
    if Rails.env.production? and request.host.downcase != 'refreshrunner.com'
      redirect_to request.protocol + 'refreshrunner.com' + request.fullpath, :status => 301
    end
  end
  
  def trail_ended?
    if !current_user.blank? && !current_user.paid_user? && !current_user.invited_user?
      redirect_to new_charge_path if current_user.trail_ended?
    end  
  end
end
