class User < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development_sec)
	establish_connection(:development_sec)
	self.table_name = "hs_membership"
	self.primary_key = "mid"

	belongs_to :local_chapter, foreign_key: "mlcid"


end