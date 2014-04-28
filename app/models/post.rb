class Post < ActiveRecord::Base

	def to_param
    	"#{id}-#{title.gsub(/[^a-z1-9]+/i, '-')}.html"
	end

	validates :content, presence: true
	validates :title, presence: true

end
