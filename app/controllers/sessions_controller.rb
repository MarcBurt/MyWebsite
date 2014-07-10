class SessionsController < ApplicationController
	def create
		@auth = request.env["omniauth.auth"]
		@user = User.find_by(provider: @auth["provider"], uid: @auth["uid"]) || User.create_with_omniauth(@auth)
		set_name 
		set_image
		set_session
		set_admin if @auth[:info][:email] == 'marc.burt@gmail.com' # hard coded admin to owners email
		redirect_to root_url
		flash[:notice] = "Signed in!"
	end

	def destroy
 		 clear_session
 		 redirect_to root_url
 		 flash[:notice] = "You have been signed out!"
	end
end




	private

	def set_admin
		@user[:admin] = true 
		@user.save
	end

	def set_name
		@user[:name] = @auth[:info][:name] #overwrite in case name is updated
		if @user[:name] == "" || @user[:name] == nil  #if name is blank
			if @auth[:info][:nickname] != nil
				@user[:name] = @auth[:info][:nickname] #set to nickname if not nil
			else
				@user[:name] = @user[:uid] #set to provider UID otherwise
			end
		end
		@user.save
	end

	def set_image
		if @auth[:info][:image]
			@user[:image] = @auth[:info][:image]
		else 
			@user[:image] = "image not set!"
		end
		@user.save
	end

	def set_session
		session[:user_id] = @user.id
		session[:user_uid] = @user[:uid]
		session[:user_provider] = @user[:provider]
	end

	def clear_session
		session[:user_id] = nil
		session[:user_uid] = nil
		session[:user_provider] = nil
	end

		

