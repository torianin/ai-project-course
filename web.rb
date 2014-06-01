require 'sinatra'
require './app/model'
require './app/programr'
require 'pusher'

set :protection, :except => :frame_options
Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

class Protected < Sinatra::Base
	
	def createModel
		p = PostgresConnector.new()
		p.connect
		p.createTables
		p.disconnect
	end

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == 'test'
  end

  get '/reset' do
    createModel
  end

  get '/another' do
    "another secret"
  end

end

class Public < Sinatra::Base
	get '/' do
		erb :index
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
end