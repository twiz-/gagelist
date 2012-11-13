class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :user_id, :due_date
  
  belongs_to :list
  belongs_to :user
  
  
  scope :completed, where(:completed => true).order('position')
  
  scope :incomplete, where(:completed => false).order('position')
  
  acts_as_list
  
def self.incompletes(list_id)
  where('list_id =? AND completed  = ?', list_id, false).order('position')
end
  
 def self.who_are_we_waiting_on(list)
   where(list_id: list).order('due_date ASC').incomplete.first
 end
 
 def self.who_is_next(list)
   where(list_id: list).order('due_date ASC').incomplete.second
 end 
end
