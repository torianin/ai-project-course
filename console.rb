require 'pusher'
require 'pusher-client'
require 'pp'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

APP_KEY = '0b6500a2c511ef6a91ba'

socket = PusherClient::Socket.new(APP_KEY)

socket.subscribe('sended-message')

socket['sended-message'].bind('sended-message') do |data|
  pp data
end

socket.connect

message = ''
while message!="exit"
	message = gets.chomp
	Pusher['test_channel'].trigger('my_event', {
	  message: message
	})
end

