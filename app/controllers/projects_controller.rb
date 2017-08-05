class ProjectsController < ApplicationController
  
  before_action :confirm_user
  before_action :respond_data


  def dashboard
    if(cookies[:mistl].to_i == 2 || ( cookies[:mdept].to_i == 12 and cookies[:mlcid].to_i != 1 ))
      @resp[1] = Project.where(:lcid => cookies[:mlcid].to_i).where('start_date > ?', Date.today).order("start_date ASC").limit(5)
      return
    else #(@user.mlcid == 1)
      @resp[1] = Project.where('start_date > ?', Date.today).order("start_date ASC").limit(5)
      @resp[2] = Activity.find_by_sql("select * from activities where rated = 0 limit 5")
    end
     
    # select * from activities where rated = 0 limit 5
    
    #@resp[2] = Activity.where(:rated => false).limit(5)
  end

  def show_projects
    #include pagination for futher purposes
  	if(cookies[:mistl].to_i == 2 || ( cookies[:mdept].to_i == 12 and cookies[:mlcid].to_i != 1 ))
  		@resp[1] = Project.where(:lcid => cookies[:mlcid].to_i).preload(:user).preload(:local_chapter).newest_first
  	else #(@user.mlcid == 1)
  		@resp[1] = Project.all.preload(:user).preload(:local_chapter).newest_first
  	end
    
    #@resp[1] = projects
  end

  def single_project
    @resp[1] = Project.where(:id => params[:id]).preload(:user).first
    @resp[2] = Activity.new
    @resp[3] = Feedback.new
  end

  def department_projects
    if params[:lcid].present?
      @resp[2] = return_departments(session[:user_id])
      if(cookies[:mistl].to_i == 2 || ( cookies[:mdept].to_i == 12 and cookies[:mlcid].to_i != 1 ))
        @resp[1] = Project.where(:lcid => cookies[:mlcid].to_i).preload(:user).preload(:local_chapter).preload(:activity).newest_first
        @resp[4] = Target.where(:lcid => cookies[:mlcid].to_i)
      else #(@user.mlcid == 1)
        @resp[1] = Project.where(:lcid => params[:lcid]).preload(:user).preload(:local_chapter).preload(:activity).newest_first
        @resp[4] = Target.where(:lcid => params[:lcid])
      end
    else
      @resp[2] = return_departments(session[:user_id])
      if(cookies[:mistl].to_i == 2 || ( cookies[:mdept].to_i == 12 and cookies[:mlcid].to_i != 1 ))
        @resp[1] = Project.where(:lcid => cookies[:mlcid].to_i).preload(:user).preload(:local_chapter).preload(:activity).newest_first
        @resp[4] = Target.where(:lcid => cookies[:mlcid].to_i)
      else #(@user.mlcid == 1)
        @resp[1] = Project.all.preload(:user).preload(:local_chapter).preload(:activity).newest_first
        @resp[4] = []
      end
    end

    @resp[3] = LocalChapter.all

  end


  def new_project
    department = [0,1,2,3,4,5,6,7,8,9,10,11]
    departments = []
    synergy_departments = department
    if cookies[:mdept].to_i == 12
      departments = [1,2,3,4,5,6,7,8,9,10,11]
    else
      departments << cookies[:mdept].to_i
      synergy_departments = synergy_departments - [cookies[:mdept].to_i]
      if cookies[:mdept2].to_i > 0
        departments << cookies[:mdept2].to_i
        synergy_departments = synergy_departments - [cookies[:mdept2].to_i]
      end
    end

    #@resp[0] = user
    @resp[1] = Project.new
    @resp[2] = LocalChapter.where(:lcid => cookies[:mlcid].to_i)
    @resp[3] = departments
    @resp[4] = synergy_departments

  end

  def create_project
  	
  	@resp[1] = Project.new(project_params)
    #user = User.find_by(mid: session[:user_id])
    department = [0,1,2,3,4,5,6,7,8,9,10,11]
    departments = []
    synergy_departments = department
    if cookies[:mdept].to_i == 12
      departments = [1,2,3,4,5,6,7,8,9,10,11]
    else
      departments << cookies[:mdept].to_i
      synergy_departments = synergy_departments - [cookies[:mdept].to_i]
      if cookies[:mdept2].to_i > 0
        departments << cookies[:mdept2].to_i
        synergy_departments = synergy_departments - [cookies[:mdept2].to_i]
      end
    end

    @resp[2] = LocalChapter.where(:lcid => cookies[:mlcid].to_i)
    @resp[3] = departments
    @resp[4] = synergy_departments

  	@resp[1].mid = session[:user_id]
  	@resp[1].lcid = cookies[:mlcid].to_i
  	if @resp[1].save
  		redirect_to(:action => 'show_projects')
  	else
  		render('new_project')
  	end

  end

  def edit_project
  	#use helpers here before reaching to edit option
  	@resp[1] = Project.find(params[:id])
      #user = User.find_by(mid: session[:user_id])
    @resp[2] = LocalChapter.where(:lcid => @resp[1].lcid)
    
    departments = []
    synergy_departments = [0,1,2,3,4,5,6,7,8,9,10,11]
    if cookies[:mdept].to_i == 12 or cookies[:mlcid].to_i == 1
      departments = [1,2,3,4,5,6,7,8,9,10,11]
    else
      departments << cookies[:mdept].to_i
      synergy_departments = synergy_departments - [cookies[:mdept].to_i]
      if cookies[:mdept2].to_i > 0
        departments << cookies[:mdept2].to_i
        synergy_departments = synergy_departments - [cookies[:mdept2].to_i]
      end
    end
    #@resp[0] = user
    @resp[3] = departments
    @resp[4] = synergy_departments

  end

  def update_project
    #@resp[0] = User.find_by(mid: session[:user_id])
    @resp[1] = Project.find(params[:id])
    @resp[2] = LocalChapter.where(:lcid => @resp[1].lcid)

    department = [0,1,2,3,4,5,6,7,8,9,10,11]
    departments = []
    synergy_departments = department
    if cookies[:mdept].to_i == 12 or cookies[:mlcid].to_i == 1
      departments = [1,2,3,4,5,6,7,8,9,10,11]
    else
      departments << cookies[:mdept].to_i
      synergy_departments = synergy_departments - [cookies[:mdept].to_i]
      if cookies[:mdept2].to_i > 0
        departments << cookies[:mdept2].to_i
        synergy_departments = synergy_departments - [cookies[:mdept2].to_i]
      end
    end

    @resp[3] = departments
    @resp[4] = synergy_departments

	  	if @resp[1].update_attributes(project_params)
        flash[:notice] = "Project Updated successfully."
	  		redirect_to(:action => 'single_project',:id => @resp[1].id)
	  	else
	  		render("edit_project")
	  	end

  end

  def create_activity
    #@resp[0] = User.find_by(mid: session[:user_id])
    @resp[1] = Activity.new(activity_params)

    if @resp[1].save
      flash[:notice] = "Activity saved successfully."
      redirect_to(:back)
    else
      flash[:notice] = "Cannot save Activity at this moment."
      redirect_to(:back)
    end
  end

  def create_feedback
    
    #@resp[0] = User.find_by(mid: session[:user_id])
    @resp[1] = Feedback.new(feedback_params)
    
      if @resp[1].save
        flash[:notice] = "Feedback submitted successfully."
        redirect_to(:back)
      else
        flash[:notice] = "Your Feedback cannot be submitted."
        redirect_to(:back)
      end

  end


  def view_activity
    #@resp[0] = User.find_by(mid: session[:user_id])
    @resp[1] = Activity.find(params[:id])
  end

  def update_activity_status
    #user = User.find_by(mid: session[:user_id])
    activity = Activity.find(params[:id])
    if params[:status].present?
      status = params[:status]
      activity.status = status
      activity.rated = true
    end
    if activity.save
      flash[:notice] = "Activity Status changed successfully"
      redirect_to(:action => 'single_project', :id => activity.project.id)
    else
      flash[:notice] = "Activity status cannot changed right now."
      redirect_to(:back)
    end

    #@resp[0] = user
    @resp[1] = activity

  end

  def update_activity
    #user = User.find_by(mid: session[:user_id])
    activity = Activity.find(params[:id])
    activity.rated = false
    activity.status = "Unrated"
    if activity.update_attributes(activity_params)
      flash[:notice] = "Activity updated successfully."
      redirect_to(:action => 'single_project', :id => activity.project.id)
    else
      flash[:notice] = "Cannot update activity right now."
      redirect_to(:back)
    end

    #@resp[0] = user
    @resp[1] = activity
  end


  def add_target
    @resp[1] = Target.new
    @resp[2] = params[:dept]
  end

  def create_target
    @resp[1] = Target.new(target_params)
    @resp[2] = params[:dept]

    if @resp[1].save
      flash[:notice] = "Target created successfully"
      redirect_to(:action => 'department_projects', :lcid => @resp[1].lcid)
    else
      flash[:notice] = "Target could not be created"
      render('add_target')
    end
  end

  def edit_target
    @resp[1] = Target.find(params[:id])
  end

  def update_target
    @resp[1] = Target.find(params[:id])
    if params[:submit].present?
      @resp[1].submit = true
    end
    if params[:draft].present?
      @resp[1].submit = false
    end
    if @resp[1].update_attributes(target_params)
      flash[:notice] = "target updated successfully"
      redirect_to(:action => 'department_projects', :lcid => @resp[1].lcid)
    else
      flash[:notice] = "Could not update target right now."
      redirect_to(:back)
    end
  end





  private #--------------------------------

  def project_params
  	params.require(:project).permit(:name,:lcid,:dept,:dept2,:synergy_function,:mid,:objective,:kpi,:mos,:start_date,:end_date)
  end

  def feedback_params
    params.require(:feedback).permit(:mid,:project_id,:description)
  end

  def activity_params
    params.require(:activity).permit(:name,:project_id,:subject,:status)
  end

  def target_params
    params.require(:target).permit(:lcid,:approval,:realization,:dept,:funds_raised,:no_recs,:productivity,:submit,:timestamp)
  end

  def respond_data()
    @resp = []
  end

  #def current_user
  # user ||= User.find(:mid => session[:user_id])
 # end

  def confirm_user
    if session[:user_id]
      return true
    else
      flash[:notice] = "please login"
      redirect_to(:controller => 'manage', :action => 'login')
      return false
    end
 end

 

  def return_departments(user_id)
    departments = []
    if cookies[:mdept].to_i == 12
      # aiesec india can watch all the projects
      # total there are 10 dept
      #bd and F are in every lc
      # tm and mkt to be confirmed
      # 0 - None, 1 - iGT, 2 - iGV, 3 - oGT, 4 - oGV, 5 - iGE, 6 - oGE,
      # 7 - TM, 8 - MKT, 9 - BD, 10 - F, 11 - Other, 12 - LCP
      departments = ["IGT","IGV","OGT","OGV","IGE","OGE","TM","MKT","BD","F"]
    else
      departments << helpers.department_name(cookies[:mdept].to_i).upcase
      if cookies[:mdept2].present?
        departments << helpers.department_name(cookies[:mdept2].to_i).upcase
      end
    end
    return departments
  end

end