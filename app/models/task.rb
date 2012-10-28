class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :user_id
  
  belongs_to :list
  belongs_to :user
  
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
  def self.most_recent
    first(:order => 'id DESC') # or whatever query you need to get the most recent
  end
  
  
end
