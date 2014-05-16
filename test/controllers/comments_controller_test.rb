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

