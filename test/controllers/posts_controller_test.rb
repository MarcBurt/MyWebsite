require 'test_helper'

class PostsControllerTest < ActionController::TestCase

	setup do
		@post1 = posts(:one)
		@post2 = posts(:two)
		@comment = comments(:one)
	end

	should "have a comment for @post1" do
		assert @post1.comments.first
	end

	should "be able to view both posts on index" do
		get :index
		assert_response :success
		assert_match "Second post content", response.body
	end

	should "redirect if creating post when not logged in" do
		post :create, post:{ title:"1", content: "test" }
		assert_redirected_to login_path
	end

	should "redirect if updating post when not logged in" do
		post :update, id: @post2, post: { title:"2", content:"updated post"}
		assert_redirected_to login_path
	end

	should "redirect if deleting post when not logged in" do
		post :destroy, id: @post1
		assert_redirected_to login_path
	end

	context "logged in, not admin" do
		setup do
			@current_user = users(:user)
			session[:user_id] = @current_user.id
		end

		should "display permissions error if creating post without admin" do
			post :create, post:{ title:"1", content: "test" }
			assert_response :redirect
			assert_equal flash[:notice], "You do not have permission to do that"
		end

		should "display permissions error if updating post without admin" do
			post :update, id: @post2, post: { title:"2", content:"updated post"}
			assert_response :redirect
			assert_equal flash[:notice], "You do not have permission to do that"
		end

		should "display permissions error if deleting post without admin" do
			post :destroy, id: @post1
			assert_response :redirect
			assert_equal flash[:notice], "You do not have permission to do that"
		end

	end



	context "when logged in as admin" do
		setup do
			@current_user = users(:admin)
			session[:user_id] = @current_user.id
		end


		should "be able to view the #new page" do
			get :new
			assert_response :success
		end
		
		should "be able to create a new post" do
			assert_difference('Post.count') do
				post :create, post:{ title:"1", content: "test" }
			end
		end

		should "display an error if title blank" do
			assert_no_difference('Post.count') do
				post :create, post:{ title:"", content: "content" }
			end
			assert_match "Title can&#39;t be blank", response.body
		end

		should "display an error if content blank" do
			assert_no_difference('Post.count') do
				post :create, post:{ title:"2", content: "" }
			end
			assert_match "Content can&#39;t be blank", response.body
		end
				

		context "#show" do
			setup do
				get :show, id: @post1
			end

			should "display posts page when id is given" do
				assert_response :success
			end

			should "display posts title in URL" do
				assert_match "First", request.url      #search for First in the URL
			end

			should "see comments for a post" do
				assert_match "Comment for Post 1", response.body
			end

		end

		should "be able to load the #edit page" do
			get :edit, id: @post1
			assert_response :success
		end

		should "be able to update a post" do
			post :update, id: @post2, post: { title:"2", content:"updated post"}

			assert_response :redirect
			get :index
			assert_match "updated post", response.body
		end

		should "be able to delete a post" do
			post :destroy, id: @post1
			assert_response :redirect
			assert_no_match 'Second', response.body
		end

	end

end

