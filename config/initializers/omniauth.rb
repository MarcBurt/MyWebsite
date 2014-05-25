
Rails.application.config.middleware.use OmniAuth::Builder do
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	provider :facebook, ENV['facebook_key'], ENV['facebook_secret']
	provider :linkedin, ENV['linkedin_key'] , ENV['linkedin_secret'] 
	provider :github, ENV['github_key'] , ENV['github_secret'], scope: "user"
	provider :gplus, ENV['gplus_key'] , ENV['gplus_secret']

	#OmniAuth.config.test_mode = true #turns test mode - auto authorizr the mock user on or off

	OmniAuth.config.add_mock(:twitter, {provider: 'twitter', uid: '12345', info:{email: 'test@test.com'}})
end


