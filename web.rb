require 'sinatra'
require './app/model'
require './app/programr'
require 'pusher'

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
	Pusher['sended-message'].trigger('sended-message', {:message => "#{query}"})
	if params[:query] == 'Cześć Robcio'
		return "[[b;red;black]Kocham Cię]"
	else
		return $alice.askAlice(query)
	end
end
