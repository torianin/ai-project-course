require 'pusher'
require 'pusher-client'
require 'pp'
require 'pusher'
require 'json'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

APP_KEY = '0b6500a2c511ef6a91ba'

users = Array.new

PusherClient.logger = Logger.new(STDOUT)
PusherClient.logger.level = Logger::WARN

socket = PusherClient::Socket.new(APP_KEY)

socket.subscribe('sended-message')

socket['sended-message'].bind('sended-message') do |data|
  message_hash = JSON.parse("#{data}")
  users.push("#{message_hash["userid"]}") unless users.include?("#{message_hash["userid"]}")
  puts message_hash["message"] + " " + users.index("#{message_hash["userid"]}").to_s
end

socket.connect(true) # Connect asynchronously

message = ''
while message!="exit"
	message = gets.chomp
	number = gets.chomp
	if number.to_i == -1
		users.each { |user|
			Pusher['test_channel'].trigger(user, {
			  message: message
			})
		}
	else
		Pusher['test_channel'].trigger("#{users.at(number.to_i)}", {
		  message: message
		})
	end
end

