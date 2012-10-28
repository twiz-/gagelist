class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         has_many :tasks
         has_many :lists
         

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name
  # attr_accessible :title, :body
  
  def full_name
    first_name + " " + last_name
    # I think that graavatar shit goes here!!!!
  end
  
  def gravatar_url
    stripped_email  = email.strip
    downcased_email = stripped_email.downcase
    hash            = Digest::MD5.hexdigest(downcased_email)
    
    "http://gravatar.com/avatar/#{hash}"
  end
    
  def on_deck
    #This will most likely need to take the task in ascending order and check if it is completed
    #id it's not complete render it on this page and show who it is assigned to. Baby
  end
  
end
