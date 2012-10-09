class List < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :tasks
  
  validates :name, :presence => true
end
