require 'sinatra'
require './app/model'

get '/' do
	query = params[:query]
	if query
		addQuery(query)
	end
	erb :index
end

get '/reset' do
	createModel
end

get '/ask' do
	query = params[:query]
	addQuery(query)
end