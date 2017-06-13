class ProjectsController < ApplicationController
  
  before_action :confirm_user


  def dashboard
  	@user = User.where(:mid => session[:user_id]).first
  end

  def show_projects
    #include pagination for futher purposes
  	@user = User.where(:mid => session[:user_id]).first
  	if(@user.mistl == 2 || ( @user.mdept == 12 and @user.mlcid != 1 ))
  		@projects = Project.where(:lcid => @user.mlcid).newest_first
  	else #(@user.mlcid == 1)
  		@projects = Project.all.newest_first
  	end
  end

  def single_project
    @user = User.where(:mid => session[:user_id]).first
    @project = Project.where(:id => params[:id]).first
    @activity = Activity.new
    @feedback = Feedback.new
  end

  def department_projects
    @user = User.where(:mid => session[:user_id]).first
    @departments = helpers.return_departments(session[:user_id])
    if(@user.mistl == 2 || ( @user.mdept == 12 and @user.mlcid != 1 ))
      @projects = Project.where(:lcid => @user.mlcid).newest_first
    else #(@user.mlcid == 1)
      @projects = Project.all.newest_first
    end
    @lcs = LocalChapter.all
  end

  def chapter_projects
    @user = User.where(:mid => session[:user_id]).first
    if @user.mlcid == 1
      @projects = Project.all.newest_first
    else
    @projects = Project.where(:lcid => @user.mlcid).newest_first
    end
  end

  def new_project
    @project = Project.new
  	@user = User.where(:mid => session[:user_id]).first
  	@lcs = LocalChapter.where(:lcid => @user.mlcid)
    department = [0,1,2,3,4,5,6,7,8,9,10,11]
    @departments = []
    @synergy_departments = department
    if @user.mdept == 12
      @departments = [1,2,3,4,5,6,7,8,9,10,11]
    else
      @departments << @user.mdept
      @synergy_departments = @synergy_departments - [@user.mdept]
      if @user.mdept2 > 0
        @departments << @user.mdept2
        @synergy_departments = @synergy_departments - [@user.mdept2]
      end
    end

  end

  def create_project
  	
  	@project = Project.new(project_params)
    @user = User.where(:mid => session[:user_id]).first
    @lcs = LocalChapter.where(:lcid => @user.mlcid)
    department = [0,1,2,3,4,5,6,7,8,9,10,11]
    @departments = []
    @synergy_departments = department
    if @user.mdept == 12
      @departments = [1,2,3,4,5,6,7,8,9,10,11]
    else
      @departments << @user.mdept
      @synergy_departments = @synergy_departments - [@user.mdept]
      if @user.mdept2 > 0
        @departments << @user.mdept2
        @synergy_departments = @synergy_departments - [@user.mdept2]
      end
    end
  	@project.mid = session[:user_id]
  	@project.lcid = @user.mlcid
  	if @project.save
  		redirect_to(:action => 'show_projects')
  	else
  		render('new_project')
  	end
  end

  def edit_project
  	#use helpers here before reaching to edit option
  	if (helpers.authorize_to_edit(session[:user_id],params[:id]))
  		@project = Project.find(params[:id])
      @user = User.where(:mid => session[:user_id]).first
      @lcs = LocalChapter.where(:lcid => @user.mlcid)
  	else
  		flash[:notice] = "You are not authorized for this action"
  		redirect_to(:action => 'show_projects')	
  	end

  end

  def update_project
    @user = User.where(:mid => session[:user_id]).first
  	if (helpers.authorize_to_edit(session[:user_id],params[:id]))
	  	@project = Project.find(params[:id])
      @lcs = LocalChapter.where(:lcid => @user.mlcid)
	  	if @project.update_attributes(project_params)
        flash[:notice] = "Project Updated successfully."
	  		redirect_to(:action => 'single_project',:id => @project.id)
	  	else
	  		render('edit_project')
	  	end
	  else
		flash[:notice] = "You are not authorized for this action"
  	redirect_to(:action => 'show_projects')	
	  end

  end

  def create_activity
    @user = User.where(:mid => session[:user_id]).first
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:notice] = "Activity saved successfully."
      redirect_to(:back)
    else
      flash[:notice] = "Cannot save Activity at this moment."
      redirect_to(:action => 'show_projects')
    end
  end

  def create_feedback
    
    @user = User.where(:mid => session[:user_id]).first
    @feedback = Feedback.new(feedback_params)
    
      if @feedback.save
        flash[:notice] = "Feedback submitted successfully."
        redirect_to(:back)
      else
        flash[:notice] = "Your Feedback cannot be submitted."
        redirect_to(:action => 'one_project',:id => params[:id])
      end
  end

  def view_activity
    @user = User.where(:mid => session[:user_id]).first
    @activity = Activity.find(params[:id])
  end

  def update_activity_status
    @user = User.where(:mid => session[:user_id]).first
    @activity = Activity.find(params[:id])
    if params[:status].present?
      status = params[:status]
      @activity.status = status
      @activity.rated = true
    end
    if @activity.save
      flash[:notice] = "Activity Status changed successfully"
      redirect_to(:action => 'single_project', :id => @activity.project.id)
    else
      flash[:notice] = "Activity status cannot changed right now."
      redirect_to(:back)
    end
  end

  def update_activity
    @user = User.where(:mid => session[:user_id]).first
    @activity = Activity.find(params[:id])
    @activity.rated = false
    @activity.status = "Unrated"
    if @activity.update_attributes(activity_params)
      flash[:notice] = "Activity updated successfully."
      redirect_to(:action => 'single_project', :id => @activity.project.id)
    else
      flash[:notice] = "Cannot update activity right now."
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

  def confirm_user
    if session[:user_id]
      return true
    else
      flash[:notice] = "please login"
      redirect_to(:controller => 'manage', :action => 'login')
      return false
  end
 end

end