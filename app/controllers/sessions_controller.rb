class SessionsController < ApplicationController
  def new
  end

  def create
	  @user = User.find_by_email(params[:email])
	  if @user.password == params[:password]
  		flash[:notice] = "You've been logged in."
  		session[:user_id] = @user.user_id
  		redirect_to root_url
  	else
  		flash[:alert] = "There was a problem logging you in."
  		redirect_to sign_in_path
  	end
  end

  def destroy
  	session[:user_id] = nil
  	flash[:notice] = "You have been logged out"
  	redirect_to root_url
  end
end
