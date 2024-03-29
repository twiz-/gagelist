class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :user_id, :due_date
  
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}, except: [:update], recipient: proc {|controller, model| model.list }
 
  belongs_to :list
  belongs_to :user
 
  validates :user_id, :list_id, :description, :presence => true
 
  scope :completed, where(:completed => true).order('position')
  scope :incomplete, where(:completed => false).order('position')
  scope :by_assignee, lambda{ |userid| where(user_id: userid) }
  acts_as_list
  scope :ordered, order('position asc')
  
  def user_gravatar
    self.user.gravatar_url
  end
  
  def self.incompletes(list_id, user_id)
    where('list_id =? AND completed  = ? AND user_id = ?', list_id, false, user_id).order('position')
  end

  def self.completes(list_id, user_id)
   where('list_id =? AND completed  = ? AND user_id = ?', list_id, true, user_id).order('position')
  end
end
