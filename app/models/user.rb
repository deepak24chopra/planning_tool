class User < ApplicationRecord

	#ActiveRecord::Base.establish_connection(:development_sec)
	establish_connection(:development_sec)
	self.table_name = "hs_membership"


end