module ApplicationHelper
	def flash_class(type)
		case type
		when :alert
			"alert-danger"
		when :notice
			"alert-success"
		else 
			""
		end
	end


private

	def current_user
	  @current_user = User.find(session[:user_id]) if session[:user_id]
	end
		
end
