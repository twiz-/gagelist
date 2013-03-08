class Payment < ActiveRecord::Base
  #attr_accessible don't set. Sensitive information.
  belongs_to :user
  
  def user_name
    user.full_name
  end
end
