class List < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  
  has_many :tasks
  belongs_to :user
  has_many :list_team_members
  has_many :members, through: :list_team_members, source: :user
  
  has_many :active_list_team_members, conditions: ["list_team_members.active = ?", true], :class_name => 'ListTeamMember'
  has_many :active_members, through: :active_list_team_members, source: :user
   
  validates :name, :description, :presence => true
  
  scope :completed, where(:complete => true)
  scope :incomplete, where(:complete => false)
  
  def owner?(user)
    self.user == user
  end
  
  def has_pending_task?
    !self.tasks.incomplete.first.blank?
  end
  
  def top_pending_task
    self.tasks.incomplete.ordered.first
  end
  
  def next_pending_task
    self.tasks.incomplete.ordered[1]
  end
  
  
  #Returns the lists with single member (creator). Another way is adding counter_cache column
  #scope :with_one_member, includes(:list_team_members).select{|l| l.list_team_members.size== 1} 
  def self.with_one_member
    joins(:list_team_members).select{|l| l.list_team_members.size == 1 } 
  end
  
  def percent_complete
    (self.tasks.completed.count.to_f / self.tasks.all.count.to_f) * 100
  end
  
  def remove_membership(member_id)
    #Clear tasks assigned to the member
    self.tasks.by_assignee(member_id).each do |task|
      task.delete
    end
    
    #Clear the membership
    membership = self.list_team_members.where(user_id: member_id).first
    membership.delete
  end 
  
end
