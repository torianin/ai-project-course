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

		def getSessionName
	      session[:name]
		end

		def setColor(text)
			return "[[i;white;black]#{text}]"
		end

		def setColorName(text,color)
			return "[[i;#{color};black]#{text}]"
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
				Pusher['sended-message'].trigger('sended-message', {:message => "#{params[:query]}", :userid =>"#{getSessionId}"})
				return setColor("Witaj #{session[:name]}, czekam na pytania :p")
			else 
				return setColor("Albo rodzice nazwali Cię mega śmiesznie, albo nie ma takiego imienia i próbujesz mnie oszukać :p")
			end
		end
		query = params[:query]
		query = removeSomeChars(query)
		addQuery(query,getSessionId)
		Pusher['sended-message'].trigger('sended-message', {:message => "#{query}", :userid =>"#{getSessionId}"})
		d = Dictionary.instance
		checkedValue = d.checkWords(query) 
		if session[:mode] == 'auto'
			if params[:query] == 'Cześć Robcio'
				return setColorName("Kocham Cię","red")
			end
			if checkedValue != true
				return setColor(checkedValue)
      end
      if checkExtra(query) != true
        return setColor(checkExtra(query))
			else
				r = Robert.instance
				replay = r.askRobert("#{query}")
				replay.force_encoding('UTF-8')
				Pusher['sended-message'].trigger('sended-message', {:message => "#{replay}", :userid =>"#{getSessionId}"})
				return setColor(replay)
			end
		else
			return nil
		end
	end
end