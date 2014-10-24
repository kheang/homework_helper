class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id
			render :show, success: "Thanks for registering. To begin using your account, check your email and verify your account."
		else
			render :new
		end

	end

	def verify
		if valid_key?
			@user.update(verified: true)
			render :show, success: "User account successfully verified"
		else
			render :show, error: "User verification failed. Please double check email or request new verification key."
		end
	end

	private

	def valid_key?
		@user = User.find_by(key: params[:key])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
