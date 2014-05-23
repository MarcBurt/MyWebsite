class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def logged_using_omniauth?
		@current_user = User.find(session[:user_id]) if session[:user_id]
		redirect_to login_path unless @current_user
	end
end
