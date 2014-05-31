require 'sinatra'
require './app/model'
require './app/programr'

set :protection, :except => :frame_options

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
		return "[[b;red;black]Kocham Cię]"
	else
		return $alice.askAlice(query)
	end
end
