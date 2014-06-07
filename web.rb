require 'sinatra'
require './app/model'
require './app/utilities'
require './app/programr'
require './app/config'
require 'pusher'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

class Protected < Sinatra::Base

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == 'wXpwGdK7MwB8jquPAZbzBG'
  end

  get '/reset' do
    createModel
  end

  get '/auto' do
    $mode = "auto"
    "Tryb automatyczny"
  end

  get '/manual' do
    $mode = "manual"
    "Tryb manualny"
  end

end

class Public < Sinatra::Base
	set :protection, :except => :frame_options
  	enable :sessions
 	set :session_secret, 'nothing is secret on internet'

	helpers do
		def getSessionId
	      session[:session_id]
		end
	end

	get '/' do
		getSessionId
		erb :index
	end

	get '/session' do
		getSessionId
	end

	post '/ask' do
		query = params[:query]
		addQuery(query)
		Pusher['sended-message'].trigger('sended-message', {:message => "#{query}"})
		d = Dictionary.instance
		checkedValue = d.checkWords(query) 
		if $mode == "auto"
			if checkedValue != true
				return checkedValue
			end
			if params[:query] == 'Cześć Robcio'
				return "[[b;red;black]Kocham Cię]"
			else
				return $alice.askAlice(query)
			end
		else
			return nil
		end
	end
end