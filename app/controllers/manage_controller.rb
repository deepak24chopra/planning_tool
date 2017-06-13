class ManageController < ApplicationController
  
  def login
  end

  def authorize_user
  	if params[:email].present? && params[:password].present?
  		user = User.where(:memail => params[:email]).first
      true_user = false
  		if user && user.mpassword == params[:password]
  			true_user = true
  		end
  		
  		if(true_user and (user.mistl >= 2 or user.mdept == 12))
  			session[:mistl] = user.mistl
  			session[:mdept] = user.mdept
  			session[:user_id] = user.mid
  			flash[:notice] = "You are logged in."
  			redirect_to(:controller => 'projects',:action => 'dashboard')
  		else
  			flash[:notice] = "Username/password combination not correct."
  			redirect_to(:action => "login")
  		end
    else
      flash[:notice] = "Missing password or email."
      redirect_to(:action => 'login')
  	end
  end

  def logout
  	session[:mistl] = nil
  	session[:mdept] = nil
  	session[:user_id] = nil
  	flash[:notice] = "Logged out successfully"
  	redirect_to(:action => "login")
  end
end