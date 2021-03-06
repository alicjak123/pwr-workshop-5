class RegistrationsController < ApplicationController
  def new
  	@user = User.new
  end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome!"
			redirect_to root_path
		else
			flash[:alert] = "Try again"
			render "new"
		end
	end

	private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
