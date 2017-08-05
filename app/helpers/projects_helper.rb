module ProjectsHelper

	def authorize_to_edit(project_id)
		#returns true or false if user is allowed to edit or not
		#national presidents and national vice president can edit all projects oll over india
		project = project_id
		if(cookies[:mlcid].to_i == 1) #lcid 1 means national level president or vp : can edit all
			return true
		elsif(cookies[:mdept].to_i ==12 and cookies[:mlcid].to_i == project.lcid) 
		#local president : can edit all projects of his local chapter
			return true
		elsif(cookies[:mistl].to_i == 2 and (
			cookies[:mdept].to_i  == project.dept  ||
			cookies[:mdept].to_i  == project.dept2 ||
			cookies[:mdept2].to_i == project.dept  ||
			cookies[:mdept2].to_i == project.dept2
			))
		#local vice president : can view all the projects but edits only of his department
			project = nil
			return true
		else
			project = nil
			return false
		end		
	end

	

	def return_department_number(dept_name)
		# 0 - None, 1 - iGT, 2 - iGV, 3 - oGT, 4 - oGV, 5 - iGE, 6 - oGE,
		# 7 - TM, 8 - MKT, 9 - BD, 10 - F, 11 - Other, 12 - LCP
		department = {"IGT" => 1, "IGV" => 2, "OGT" => 3, "OGV" => 4,
						"IGE" => 5, "OGE" => 6, "TM" => 7, "MKT" => 8, "BD" => 9,
						"F" => 10, "Others" => 11, "LCP" => 12}
		number = department["#{dept_name}"]
		department = nil
		return number
	end


	def authorize_for_activity(project_id)
		project = project_id
		if(cookies[:mlcid].to_i == 1) #lcid 1 means national level president or vp : can edit all
			return true
		elsif(cookies[:mdept].to_i == 12 and cookies[:mlcid].to_i == project.lcid) 
		#local president : can edit all projects of his local chapter
			return true
		elsif(cookies[:mistl].to_i == 2 and (
			cookies[:mdept].to_i  == project.dept  ||
			cookies[:mdept].to_i  == project.dept2 ||
			cookies[:mdept2].to_i == project.dept  ||
			cookies[:mdept2].to_i == project.dept2
			))
		#local vice president : can view all the projects but edits only of his department
		project = nil
			return true
		else
			project = nil
			return false
		end	
	end

	def authorize_for_feedback()
		if cookies[:mlcid].to_i == 1
			return true
		else
			return false
		end
	end


	def authorize_to_edit_activity(activity_id)
		activity = activity_id
		if cookies[:mdept].to_i == 12 and cookies[:mlcid].to_i == activity.project.lcid
			activity = nil
			return true
		elsif( cookies[:mistl].to_i == 2 and (
			cookies[:mdept].to_i  == activity.project.dept  ||
			cookies[:mdept].to_i  == activity.project.dept2 ||
			cookies[:mdept2].to_i == activity.project.dept  ||
			cookies[:mdept2].to_i == activity.project.dept2
			))
		activity = nil
			return true
		else
			activity = nil
			return false
		end
	end


	def department_projects(projects, department_no)
		project1 = projects.select { |project| project.dept == department_no }
        project2 = projects.select { |project| project.dept2 == department_no }
        project3 = project1 + project2
        project1 = nil
        project2 = nil
        return project3
	end



end