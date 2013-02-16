class List < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  
  has_many :tasks
  belongs_to :user
  has_many :list_team_members
  has_many :members, through: :list_team_members, source: :user
  
  has_many :active_list_team_members, conditions: ["list_team_members.active = ?", true], :class_name => 'ListTeamMember'
  has_many :active_members, through: :active_list_team_members, source: :user
   
  validates :name, :description, :presence => true
  
  #Returns the lists with single member (creator). Another way is adding counter_cache column
  #scope :with_one_member, includes(:list_team_members).select{|l| l.list_team_members.size== 1} 
  def self.with_one_member
    joins(:list_team_members).select{|l| l.list_team_members.size == 1 } 
  end
  
  def percent_complete
    (self.tasks.completed.count.to_f / self.tasks.all.count.to_f) * 100
  end
  
   
end
