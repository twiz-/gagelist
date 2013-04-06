class ActivityView < ActiveRecord::Base
  attr_accessible :viewed_on, :viewer_id
  belongs_to :viewer, class_name: 'User'
end
