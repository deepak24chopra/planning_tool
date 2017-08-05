class ManageController < ApplicationController
  
  def login
  end

  def authorize_user
  	if params[:email].present? && params[:password].present?
  		user = User.where('memail=? or mnetemail=?',params[:email],params[:email]).preload(:local_chapter).first
      true_user = false
  		if user && user.mpassword == params[:password]
  			true_user = true
  		end
  		
  		if(true_user and (user.mistl >= 2 or user.mdept == 12))
        cookies[:mistl] = user.mistl
  			cookies[:mdept] = user.mdept
  			session[:user_id] = user.mid
        cookies[:user_name] = user.mname
        cookies[:chapter] = user.local_chapter.lcname
        cookies[:mlcid] = user.mlcid
        if user.mdept2 > 0
          cookies[:mdept2] = user.mdept2
        end
  			flash[:notice] = "You are logged in."
        user = nil
        true_user = nil
  			redirect_to(:controller => 'projects',:action => 'dashboard')
  		else
  			flash[:notice] = "Username/password combination not correct."
        user = nil
        true_user = nil
  			redirect_to(:action => "login")
  		end
    else
      flash[:notice] = "Missing password or email."
      redirect_to(:action => 'login')
  	end
  end

  def logout
  	session[:user_id] = nil
    cookies[:mistl] = nil
    cookies[:mdept] = nil
    cookies[:user_name] = nil
    cookies[:chapter] = nil
    cookies[:mlcid] = nil
    if cookies[:mdept2].present?
        cookies[:mdept2] = nil
    end

  	flash[:notice] = "Logged out successfully"
  	redirect_to(:action => "login")
  end
end