require 'test_helper'

class CommentTest < ActiveSupport::TestCase

	should belong_to(:post)
end

