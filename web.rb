require 'sinatra'
require './app/model'

get '/' do
	erb :index
end

get '/reset' do
	createModel
end

post '/ask' do
  "You said '#{params}'"
end