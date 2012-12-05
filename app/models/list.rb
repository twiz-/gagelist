class List < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  
  has_many :tasks
  belongs_to :user
  has_many :list_team_members
  
  validates :name, :presence => true
  
  def percent_complete
    (self.tasks.completed.count.to_f / self.tasks.all.count.to_f) * 100
  end
  
end
