class LoginsController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    redirect_to new_login_path unless valid_key?
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to root_path, success: 'You are successfully logged in.'
    else
      redirect_to new_login_path, alert: 'Your email and password were invalid.'
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path, success: 'You have been logged out.'
  end

end
