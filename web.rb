require 'sinatra'
require './app/model'
require './app/programr'

get '/' do
	erb :index
end

get '/create' do
	createAlice
end

get '/reset' do
	createModel
end

post '/ask' do
	query = params[:query]
	addQuery(query)
	if params[:query] == 'Cześć Robcio'
		return "[[b;red;black]Kocham Cię]"
	else
		return askAlice(query)
	end
end