class ApplicationController < ActionController::Base
  protect_from_forgery     
  before_filter :check_domain
  def check_domain
    if Rails.env.production? and request.host.downcase != 'refreshrunner.com'
      redirect_to request.protocol + 'refreshrunner.com' + request.fullpath, :status => 301
    end
end
