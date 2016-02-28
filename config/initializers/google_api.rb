# require 'google/api_client'


# client.authorization = Signet::OAuth2::Client.new(
#         :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
#         :audience             => 'https://accounts.google.com/o/oauth2/token',
#         :scope                => 'https://www.googleapis.com/auth/analytics.readonly',
#         :issuer               => ENV['client_email'],
#         :signing_key          => Google::APIClient::PKCS12.load_key(PATH_TO_KEY_FILE, 'notasecret')
#       ).tap { |auth| auth.fetch_access_token! }

#       api_method = client.discovered_api('analytics','v3').data.ga.get


#       # make queries
#       @results = client.execute(:api_method => api_method, :parameters => {
#         'ids'        => PROFILE,
#         'start-date' => Date.new(1970,1,1).to_s,
#         'end-date'   => Date.today.to_s,
#         'dimensions' => 'ga:pagePath',
#         'metrics'    => 'ga:pageviews',
#         'filters'    => 'ga:pagePath==/url/to/user'
#       })

#       # puts result.data.rows.inspect