require 'test_helper'

class PostsControllerTest < ActionController::TestCase

setup do
	@post1 = posts(:one)
	@post2 = posts(:two)
end

	context "#index'" do

		should "be able to view both posts" do
			get :index
			assert_response :success
			assert_match "Second post content", response.body
		end
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

	end


end
