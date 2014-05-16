require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	setup do
		@post1 = Post.create(title: "post", content: "post content", id: 5)
	end

	should "be render the #new page " do
		get :new, id: @post1[:id]
		assert_response :success
	end

	should "be able to create a comment" do
		assert_difference( 'Comment.count', 1 ) do
			post :create, comment: {content: 'Test', post_id: 5}
		end		
	end
end
