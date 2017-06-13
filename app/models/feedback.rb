class Feedback < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development)
	establish_connection(:development)

	self.table_name = "feedback"
	belongs_to :project , foreign_key: 'project_id'

end