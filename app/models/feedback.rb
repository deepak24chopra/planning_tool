class Feedback < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development)
	establish_connection(:development)

	self.table_name = "feedback"
	belongs_to :project , foreign_key: 'project_id'
	belongs_to :user , foreign_key: 'mid'

	validates :description, presence: true 

end