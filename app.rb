require 'sinatra'

get '/' do
  @cookie = request.cookies['time']
  erb :index
end

get '/set-cookies' do
  response.set_cookie(:time, value: Time.now, expires: Time.now + 3600 * 24, httponly: true, same_site: 'Lax')
  redirect to('/')
end