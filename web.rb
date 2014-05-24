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
	if params[:query] == 'Cześć Robcio'
		return "[[guib;FF0000]Kocham Cię]"
	else
		return "Nie kocham Cię"
	end
end