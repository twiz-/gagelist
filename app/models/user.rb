class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :first_name, :last_name, :current_password, :profile_name, :profile_name_set_on
                  
  attr_accessor :current_password
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable 
  
  validates :first_name, :last_name, :presence => true     
  validates :profile_name, :uniqueness => true     
  validates_presence_of :profile_name, :if => :profile_name_set_on?
        
  has_many :tasks
  has_many :lists
  
  has_many :active_list_team_members, :conditions => ["list_team_members.active = ?", true], :class_name => 'ListTeamMember'
  #Returns all lists, the user is involved in.
  has_many :paricipating_lists, :through => :active_list_team_members, :source => :list
  has_many :payments
  
  before_save :add_profile_name_set_date
  
  def full_name
    first_name + " " + last_name
  end

  def invited_user?
    self.profile_name.blank?
  end
  
  def trail_ended?
    trail_days_left < 0 
  end
  
  def trail_days_left
    45 - (DateTime.now - self.profile_name_set_on.to_datetime).to_i
  end
  
  def gravatar_url
    stripped_email  = email.strip
    downcased_email = stripped_email.downcase
    hash            = Digest::MD5.hexdigest(downcased_email)
    
    "https://gravatar.com/avatar/#{hash}"
  end
 
  def generate_new_confirmation_token
    self.confirmed_at = nil
    self.confirmation_token = Devise.friendly_token
    self.confirmation_sent_at = Time.now.utc
  end
  
  def stripe_customer_id
    payments.first.try(:stripe_customer_id)
  end
  
  private
  
  def add_profile_name_set_date
    self.profile_name_set_on = Time.now if !profile_name.blank? && profile_name_set_on.blank?
  end
end
