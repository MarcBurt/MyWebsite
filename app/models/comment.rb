class Comment < ActiveRecord::Base


	belongs_to :post

	validates :content, presence: true
	validates :post_id, presence: true
	validates :user_uid, presence: true
	validates :user_provider, presence: true


end

