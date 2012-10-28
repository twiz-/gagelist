class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :user_id
  
  belongs_to :list
  belongs_to :user
  
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
 def self.who_are_we_waiting_on(list)
   where(list_id: list).order('id ASC').incomplete.first
 end
 
 def self.who_is_next(list)
   where(list_id: list).order('id ASC').incomplete.second
 end
end
