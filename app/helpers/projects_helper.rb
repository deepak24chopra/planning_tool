module ProjectsHelper

	def authorize_to_edit(user_id, project_id)
		#returns true or false if user is allowed to edit or not
		#national presidents and national vice president can edit all projects oll over india
		user = User.where(:mid => user_id).first
		project = Project.where(:id => project_id).first
		if(user.mlcid == 1) #lcid 1 means national level president or vp : can edit all
			return true
		elsif(user.mdept == 12 and user.mlcid == project.lcid) 
		#local president : can edit all projects of his local chapter
			return true
		elsif(user.mistl == 2 and (
			user.mdept  == project.dept  ||
			user.mdept  == project.dept2 ||
			user.mdept2 == project.dept  ||
			user.mdept2 == project.dept2
			))
		#local vice president : can view all the projects but edits only of his department
			return true
		else
			return false
		end		
	end

	def authorize_to_create(user_id)
		#national level people will not create projects
		user = User.where(:mid => user_id).first
		if user.mlcid == 1
			return false
		else
			return true
		end
	end

	def authorize_to_read(user_id,project_id)
		user = user.where(:mid => user_id).first
		project = project.where(:id => project_id).first		
	end

	def return_departments(user_id)
		user = User.where(:mid => user_id).first
		if user.mlcid == 1
			# aiesec india can watch all the projects
			# total there are 10 dept
			#bd and F are in every lc
			# tm and mkt to be confirmed
			# 0 - None, 1 - iGT, 2 - iGV, 3 - oGT, 4 - oGV, 5 - iGE, 6 - oGE,
			# 7 - TM, 8 - MKT, 9 - BD, 10 - F, 11 - Other, 12 - LCP
			departments = ["IGT","IGV","OGT","OGV","IGE","OGE","TM","MKT","BD","F","Others"]
			return departments
		else
			lc = LocalChapter.where(:lcid => user.mlcid).first
			departments = []
			if lc.igt
				departments << "IGT"
			end
			if lc.igv
				departments << "IGV"				
			end
			if lc.ogt
				departments << "OGT"			
			end
			if lc.ogv
				departments << "OGV"
			end
			if lc.ige
				departments << "IGE"
			end
			if lc.oge
				departments << "OGE"
			end
			departments << "TM"
			departments << "MKT"
			departments << "BD"
			departments << "F"
			departments << "Others"
			return departments
		end
	end

	def department_projects(projects, department_no)
		project1 = projects.select { |project| project.dept == department_no }
        project2 = projects.select { |project| project.dept2 == department_no }
        project3 = project1 + project2
        return project3
	end

	def authorize_for_activity(user_id,project_id)
		user = User.where(:mid => user_id).first
		project = Project.where(:id => project_id).first
		if(user.mlcid == 1) #lcid 1 means national level president or vp : can edit all
			return true
		elsif(user.mdept == 12 and user.mlcid == project.lcid) 
		#local president : can edit all projects of his local chapter
			return true
		elsif(user.mistl == 2 and (
			user.mdept  == project.dept  ||
			user.mdept  == project.dept2 ||
			user.mdept2 == project.dept  ||
			user.mdept2 == project.dept2
			))
		#local vice president : can view all the projects but edits only of his department
			return true
		else
			return false
		end	
	end

	def authorize_for_feedback(user_id)
		user = User.where(:mid => user_id).first
		if user.mlcid == 1
			return true
		else
			return false
		end
	end

	def return_department_name(dept_id)
		departments = ["None","IGT","IGV","OGT","OGV","IGE","OGE","TM","MKT","BD","F","Others"]
		return departments[dept_id]
	end

	def authorize_to_edit_activity(user_id,activity_id)
		user = User.where(:mid => user_id).first
		activity = Activity.find(activity_id)
		if user.mdept == 12 and user.mlcid == activity.project.lcid
			return true
		elsif( user.mistl == 2 and (
			user.mdept  == activity.project.dept  ||
			user.mdept  == activity.project.dept2 ||
			user.mdept2 == activity.project.dept  ||
			user.mdept2 == activity.project.dept2
			))
			return true
		else
			return false
		end
	end

	def get_unrated_activities(project_id)
		project = Project.find(project_id)
		return project.activity.unrated.count
	end


end