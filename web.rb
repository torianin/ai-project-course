require 'sinatra'
require './app/model'

get '/' do
	erb :index
end

get '/reset' do
	createModel
end

post '/ask' do
	query = params[:query]
	addQuery(query)
	"Powiedziałeś '#{params[:query]}'"
end