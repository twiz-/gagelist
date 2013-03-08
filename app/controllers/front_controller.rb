class FrontController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :trail_ended?
  
  def index
    render :layout => false
  end
  
  def benefits
  end
  
  def pricing
  end
  
  def does
  end
  
  def terms
  end
end
