require 'sinatra'
require './app/model'
require './app/utilities'
require './app/programr'
require './app/programr'
require './app/ferret'
require './app/config'
require './app/extra_questions'
require 'pusher'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

class Protected < Sinatra::Base

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == 'wXpwGdK7MwB8jquPAZbzBG'
  end

  get '/reset' do
    createModel
  end

  get '/session' do

  end

  get '/ferret/:ask' do
		r = Robert.instance
		r.askRobert(params[:ask].to_s)
  end

  post '/auto' do
		session[:mode] = 'auto'
  end

  post '/manual' do
		session[:mode] = 'manual'
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
		session[:mode] = 'auto'
		erb :index
	end

	post '/ask' do
		query = params[:query]
		addQuery(query,getSessionId)
		Pusher['sended-message'].trigger('sended-message', {:message => "#{query}", :userid =>"#{getSessionId}"})
		d = Dictionary.instance
		checkedValue = d.checkWords(query) 
		if session[:mode] == 'auto'
			if params[:query] == 'Cześć Robcio'
				return "[[b;red;black]Kocham Cię]"
			end
			if checkedValue != true
				return checkedValue
      end
      if checkExtra(query) != true
        return checkExtra(query)
			else
				a = Alice.instance
				return a.askAlice(query)
			end
		else
			return nil
		end
	end
end