class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_show_path(@user), success: 'Thank you for registering.'
    else
      render :new
    end
  end

  def activate
		@user = User.find(params[:id])
    if valid_key?(@user)
      @user.update(activated: true)
      redirect_to login_show_path(@user), success: 'User account was activated.'
    else
	    redirect_to login_show_path(@user), error: 'User activation failed. Please activate via email.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
