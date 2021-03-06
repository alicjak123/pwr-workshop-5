class SessionsController < ApplicationController
  def new
  end

  def create
	  @user = User.authenticate(params[:email], params[:password])
	  if @user
  		flash[:notice] = "You've been logged in."
  		session[:user_id] = @user.id
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
