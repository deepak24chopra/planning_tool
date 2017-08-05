class LocalChapter < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development_sec)
	establish_connection(:development_sec)

	self.table_name = "lc_list"
	self.primary_key = "lcid"
	has_many :users


end