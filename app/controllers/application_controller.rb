class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	unless logged_in?
  		flash[:error] = "You must be logged in to complete that action."
  		redirect_to root_path
  	end
  end

  def require_admin
    access_denied("Only an administrator can complete that action.") unless logged_in? && current_user.admin?
  end

  def access_denied(message)
    flash[:error] = message
    redirect_to root_path    
  end
end
