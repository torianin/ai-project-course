require 'sinatra'
require './app/model'

get '/' do
	erb :index
end

get '/reset' do
	createModel
end

get '/ask' do
	query = params[:query]
	addQuery(query)
end