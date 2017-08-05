class Target < ApplicationRecord

	establish_connection(:development)

	self.table_name = "targets"


	belongs_to :local_chapter, foreign_key: "lcid"

end