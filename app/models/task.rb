class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :user_id, :due_date
  
  belongs_to :list
  belongs_to :user
  
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
 def self.who_are_we_waiting_on(list)
   where(list_id: list).order('due_date ASC').incomplete.first
 end
 
 def self.who_is_next(list)
   where(list_id: list).order('due_date ASC').incomplete.second
 end
end
