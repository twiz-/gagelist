class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :user_id
  
  belongs_to :list
  belongs_to :user
  
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
end
