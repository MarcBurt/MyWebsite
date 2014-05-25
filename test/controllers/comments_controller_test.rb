require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	setup do
		@post1 = Post.create(title: "post", content: "post content", id: 5, )
		 
	end

	should "redirect if creating a comment whilst not logged in" do
		post :create, comment: {content: 'Test', post_id: 5}
		assert_redirected_to login_path
	end


	should "redirect if rendering the #new page " do
		get :new, id: @post1[:id]
		assert_redirected_to login_path
	end



	should "redirect if deleting a comment" do
		@comment = comments(:one)
		delete :destroy, id: @comment
		assert_redirected_to login_path
	end

	should "redirect if getting #edit" do
		@comment = comments(:one)
		get :edit, id: @comment
		assert_redirected_to login_path
	end


	should "redirect if updating a comment" do
		@comment = comments(:one)
		post :update, id: @comment, comment: { content: "Updated comment "}
		assert_redirected_to login_path
	end

	context "when logged in" do
		setup do
			# create user and session
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
			auth = request.env["omniauth.auth"]
			user = User.create_with_omniauth(auth)
			session[:user_id] = user.id
		  session[:user_uid] = user[:uid]
	   	session[:user_provider] = user[:provider]
		end

		should "be able to create a comment" do
			assert_difference( 'Comment.count', 1 ) do
				post :create, comment: {content: 'Test', post_id: 5}
			end		
		end

		should "be render the #new page " do
			get :new, id: @post1[:id]
			assert_response :success
		end


		should "be able to delete a comment" do
			@comment = comments(:one)
			assert_difference( 'Comment.count', -1 ) do
				delete :destroy, id: @comment
			end
		end

		should "be able to get #edit" do
			@comment = comments(:one)
			get :edit, id: @comment
			assert_response :success
		end


		should "be able to update a comment" do
			@comment = comments(:one)
			post :update, id: @comment, comment: { content: "Updated comment "}
			assert_equal "Your comment was updated.", flash[:notice]

		end
	end
end


