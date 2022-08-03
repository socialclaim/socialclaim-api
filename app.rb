require 'sinatra'
require 'faraday'
require 'uri'


get '/' do
  conn = Faraday.new(
    url: ENV['VUE_APP_VENLY_LOGIN_URL'],
    headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
  )

  response = conn.post('/auth/realms/Arkane/protocol/openid-connect/token') do |req|
    req.body = URI.encode_www_form({
                                     grant_type: 'client_credentials',
                                     client_id: ENV['VUE_APP_VENLY_CLIENT_ID'],
                                     client_secret: ENV['VUE_APP_SECRET_ID']
                                   })
  end
  token = JSON.parse(response.body)['access_token']
  pp token
  content_type :json
  conn = Faraday.new(
    url: ENV['VUE_APP_VENLY_API_URL'],
    headers: {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{token}" }
  )
  wallets_response = conn.get('/api/wallets')
  content_type :json
  wallets_response.body.to_json
end
