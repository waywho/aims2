OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :salesforce, 'YOUR-CONSUMER-KEY', 'YOUR-CONSUMER-SECRET'
end