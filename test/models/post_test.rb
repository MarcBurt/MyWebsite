require 'test_helper'

class PostTest < ActiveSupport::TestCase
	should have_many (:comments)

end

