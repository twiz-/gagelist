class Invitation < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :token, :accepted_at, :email, :invited_for_id, :invited_for_type
  validates :email, :presence => true
  
  attr_accessor :first_name, :last_name
  
  before_create :generate_token
  after_create :create_user, :send_invitation
  
  belongs_to :inviter, :class_name => 'User', :foreign_key => :invited_by
  belongs_to :invited_for, :polymorphic => true
  scope :pending, where(:accepted_at => nil)
  
  def generate_token
    token = Digest::MD5.hexdigest("#{self.email}#{rand(self.first_name.size)}")
    self.token = token
  end
  
  def create_user
    user = User.find_by_email(self.email)
    if user.blank?
      user = User.new(:email => self.email, :first_name => self.first_name, :last_name => self.last_name)
      #Override confirmation. Invited users doesn't need confirmation email.
      user.confirmed_at = DateTime.now 
      user.confirmation_sent_at = DateTime.now 
      
      user.save(:validate => false) #Avoid password validation
    end
    create_list_member(user, invited_for_id) 
  end
  
  def create_list_member(user, list_id)
    #Check for duplicates  
    ltm = ListTeamMember.where(:user_id => user.id).where(:list_id => list_id)
    #Else create one list member, which is not active yet.
    if ltm.first.blank?
      ListTeamMember.create(:user_id => user.id, :list_id => list_id, :active => false) 
    end  
  end
  
  def send_invitation
    InvitationMailer.invite_to_list(self).deliver
  end
  
  def accept(user)
    self.update_attributes(:token => '', :accepted_at => DateTime.now )
    
    #Make the list_member active
    ltm = ListTeamMember.where(:user_id => user.id).where(:list_id => self.invited_for_id)
    ltm.first.update_attribute('active', true)
  end
end
