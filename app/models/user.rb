class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
         
 has_many :tasks
 has_many :lists
 
 has_many :list_team_members
         
<<<<<<< HEAD
  #after_invitation_accepted :add_to_list_member
  
=======
         
  validates :first_name, :presence => true
  
  validates :last_name, :presence => true       
         

>>>>>>> 53c9aed5d354399cf4f7b0a1a6b512e7b64b8e71
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name
  # attr_accessible :title, :body
  
  def full_name
    first_name + " " + last_name
  end
  
  def gravatar_url
    stripped_email  = email.strip
    downcased_email = stripped_email.downcase
    hash            = Digest::MD5.hexdigest(downcased_email)
    
    "http://gravatar.com/avatar/#{hash}"
  end
  
  
end
