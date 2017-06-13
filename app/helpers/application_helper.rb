module ApplicationHelper


	def department_name(dept_no)
		# 0 - None, 1 - iGT, 2 - iGV, 3 - oGT, 4 - oGV, 5 - iGE, 6 - oGE,
		# 7 - TM, 8 - MKT, 9 - BD, 10 - F, 11 - Other, 12 - LCP
		departments = {0 => "None", 1 => "iGT", 2 => "iGV", 3 => "oGT", 
					   4 => "oGV", 5 => "iGE", 6 => "oGE", 7 => "TM", 
						8 => "MKT", 9 => "BD", 10 => "F", 11 => "Other", 12 => "LCP"}

		return departments[dept_no]
	end

	def local_chapter_name(lcid)
		lc = LocalChapter.where(:lcid => lcid).first
		return lc.lcname
	end

	def member_name(mid)
		member = User.where(:mid => mid).first
		return member.mname
	end

	def return_position(user_id)
		user = User.where(:mid => session[:user_id]).first
		if user.mdept == 12
			return "President"
		else
			return "Vice-President"
		end
	end

end