# encoding: utf-8

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

  get '/ferret/:ask' do
		r = Robert.instance
		r.askRobert(params[:ask].to_s)
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
		session[:name] = nil
		session[:mode] = 'auto'
		erb :index
	end

  post '/auto' do
		session[:mode] = 'auto'
  end

  post '/manual' do
		session[:mode] = 'manual'
  end
  
	post '/ask' do
		if session[:name] == nil
			if checkName(params[:query])
				session[:name] = params[:query]
				session[:sex] = checkName(params[:query])
				return "Witaj #{session[:name]}, czekam na pytania :p"
			else 
				return "Albo rodzice nazwali Cię mega śmiesznie, albo nie ma takiego imienia i próbujesz mnie oszukać :p"
			end
		end
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
				r = Robert.instance
				replay = r.askRobert("Boli mnie głowa")
				Pusher['sended-message'].trigger('sended-message', {:message => "#{replay}", :userid =>"#{getSessionId}"})
				return replay
			end
		else
			return nil
		end
	end
end