module ApplicationHelper


	def department_name(dept_no)
		# 0 - None, 1 - iGT, 2 - iGV, 3 - oGT, 4 - oGV, 5 - iGE, 6 - oGE,
		# 7 - TM, 8 - MKT, 9 - BD, 10 - F, 11 - Other, 12 - LCP
		departments = {0 => "None", 1 => "iGT", 2 => "iGV", 3 => "oGT", 
					   4 => "oGV", 5 => "iGE", 6 => "oGE", 7 => "TM", 
						8 => "MKT", 9 => "BD", 10 => "F", 11 => "Other", 12 => "LCP"}
		name = departments[dept_no]
		departments = nil
		return name
	end


end