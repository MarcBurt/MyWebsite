
Rails.application.config.middleware.use OmniAuth::Builder do
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	provider :facebook, ENV['facebook_key'], ENV['facebook_secret']
	provider :twitter, ENV['twitter_key'] , ENV['twitter_secret']
	provider :github, ENV['github_key'] , ENV['github_secret']
	provider :gplus, ENV['gplus_key'] , ENV['gplus_secret']

end

