require 'pusher'
require 'pusher-client'
require 'pp'
require 'pusher'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

APP_KEY = '0b6500a2c511ef6a91ba'

PusherClient.logger = Logger.new(STDOUT)
PusherClient.logger.level = Logger::WARN

socket = PusherClient::Socket.new(APP_KEY)

socket.subscribe('sended-message')

socket['sended-message'].bind('sended-message') do |data|
  puts data
end

socket.connect(true) # Connect asynchronously

message = ''
while message!="exit"
	message = gets.chomp
	Pusher['test_channel'].trigger('my_event', {
	  message: message
	})
end

