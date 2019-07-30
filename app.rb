require 'sinatra'
require 'sinatra/cookies'
require 'secure_headers'

use SecureHeaders::Middleware

SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true,
    httponly: true,
    samesite: {
      lax: true # mark all cookies as SameSite=Strict
    }
  }
  config.csp = {
    default_src: %w('unsafe-inline' 'self'),
    script_src: %w('unsafe-inline' 'self' storage.googleapis.com)
  }  
end

get '/' do
  @cookie = cookies[:time]
  erb :index
end

get '/set-cookies' do 
  cookies[:time] = Time.now
  redirect to('/')
end