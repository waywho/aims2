Restforce.configure do |config|
	config.username = ENV['SF_USERNAME']
	config.password = ENV['SF_PASSWORD']
  	config.client_id = ENV['SF_CONSUMER_KEY']
  	config.client_secret = ENV['SF_CONSUMER_SECRET']
  	config.host = 'test.salesforce.com'
  	config.api_version = '32.0'
end