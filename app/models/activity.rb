class Activity < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development)
	establish_connection(:development)
	#establish_connection("#{Rails.env}")
	self.table_name = "activities"
	belongs_to :project , foreign_key: 'project_id'

	scope :unrated, lambda { where(rated: 0)  }

end