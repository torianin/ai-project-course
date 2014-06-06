require 'sinatra'
require './app/model'
require './app/utilities'
require './app/programr'
require 'pusher'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

class Protected < Sinatra::Base

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == 'wXpwGdK7MwB8jquPAZbzBG'
  end

  get '/reset' do
    createModel
  end

  get '/another' do
    "another secret"
  end

end

class Public < Sinatra::Base
	set :protection, :except => :frame_options

	get '/' do
		erb :index
	end

	post '/ask' do
		query = params[:query]
		addQuery(query)
		Pusher['sended-message'].trigger('sended-message', {:message => "#{query}"})
		d = Dictionary.instance
		checkedValue = d.checkWords(query) 
		if checkedValue != true
			return checkedValue
		end
		if params[:query] == 'Cześć Robcio'
			return "[[b;red;black]Kocham Cię]"
		else
			return $alice.askAlice(query)
		end
	end
end