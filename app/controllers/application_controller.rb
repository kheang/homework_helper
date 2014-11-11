class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  add_flash_types :success, :info

  private

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def logged_in?
    !!current_user && @current_user.try(:activated)
  end

  def authenticate
    redirect_to new_login_path, warning: 'Please sign in.' unless logged_in?
  end

  def valid_key?
    @user = User.find_by(activation_key: params[:activation_key])
  end
end
