class User < ActiveRecord::Base

  has_many :comments
  has_attached_file :avatar, :styles => {:thumb => "50x50>" }. :default_url => "/images/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
		end
	end

  def avatar_from_url(url)
    self.avatar = open(url)
  end
	
end

