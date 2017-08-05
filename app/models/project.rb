class Project < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development)
	establish_connection(:development)

	self.table_name = "projects"
	has_many :activity
	has_many :feedback
	belongs_to :local_chapter, foreign_key: "lcid"
	belongs_to :user, foreign_key: "mid"

	scope :newest_first, lambda { order("projects.id DESC")  }

	#------- validations ---------------
	validates :name, :presence => {:message => "Project name cannot be left blank."}
	validates :lcid, :presence => {:message => "Local chapter should be selected."}
	validates :objective, :presence => {:message => "Objective of the project cannot be left blank."}
	validates :dept, :presence => {:message => "You have to select a department."}, numericality: { greater_than: 0 }
	validates :mid, :presence => {:message => "Member for the project missing."}, numericality: { greater_than: 0 }
	validates :start_date, :presence => {:message => "Start date cannot be blank."}
	validates :end_date, :presence => {:message => "End date cannot be blank."}
	validate :start_date_greater
	validate :end_date_greater_than_start_date
	validate :synergy_function_present


	def start_date_greater
		if start_date.present? && start_date < Date.today 
			errors.add(:start_date, "Start date shoud be today's date or ahead.")
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
		if dept2 > 0 and synergy_function.present?
			return true
		elsif dept2 > 0 and synergy_function.blank?
			errors.add(:synergy_function, "Fill up synergy function")
		elsif dept2 == 0 and synergy_function.blank?
			return true
		else
			errors.add(:dept2, "Select a synergy department also.")
		end
	end

	

end