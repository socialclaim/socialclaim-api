require 'sinatra'
require 'faraday'
require 'uri'
require "sinatra/cors"

set :allow_origin, "https://socialclaim.nescrypto.com http://localhost:3000"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"



get '/wallets' do
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
  wallets_response = conn.get('/api/wallets?identifier=socialclaim')
  pp wallets_response
  content_type :json
  wallets_response.body.to_json
end

get '/wallets/:id' do
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
  wallets_response = conn.get("/api/wallets/#{params['id']}")
  content_type :json
  wallets_response.body.to_json
end

get '/wallets/:id/events' do
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
  wallets_response = conn.get("/api/wallets/#{params['id']}/events")
  content_type :json
  wallets_response.body.to_json
end

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end
