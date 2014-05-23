require 'sinatra'
require './app/model'

get '/' do
	erb :index
end

get '/reset' do
	createModel
end

post '/ask' do
  "Powiedziałeś '#{params[:message]}'"
end