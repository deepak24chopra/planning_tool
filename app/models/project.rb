class Project < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development)
	establish_connection(:development)

	self.table_name = "projects"
	has_many :activity
	has_many :feedback

	scope :newest_first, lambda { order("projects.id DESC")  }

	#------- validations ---------------
	validates :name, presence: true 
	validates :lcid, presence: true
	validates :dept, presence: true, numericality: { greater_than: 0 }
	validates :mid, presence: true, numericality: { greater_than: 0 }
	validates_presence_of  :start_date, :end_date
	validate :start_date_greater
	validate :end_date_greater_than_start_date
	validate :synergy_function_present


	def start_date_greater
		if start_date.present? && start_date < Date.today 
			errors.add(:start, "Start date shoud be today's date or ahead.")
		end
	end

	def end_date_greater_than_start_date
		if start_date.present? && end_date.present?
			if end_date.to_s < start_date.to_s
				errors.add(:end_date, "End Date should be greater than start date.")
			end
		end
	end

	def synergy_function_present
		if dept2 > 0
			if synergy_function.present?
				return true
			else
				errors.add(:synergy_function, "Fill up synergy function")
			end
		else
			return true
		end
	end

end