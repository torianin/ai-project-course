require 'rubygems'
require 'pusher'
require 'pusher-client'
require 'pusher'
require 'json'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

APP_KEY = '0b6500a2c511ef6a91ba'

users = Array.new

PusherClient.logger = Logger.new(STDOUT)
PusherClient.logger.level = Logger::WARN

socket = PusherClient::Socket.new(APP_KEY)

socket.subscribe('sended-message')

last_message = ""

socket['sended-message'].bind('sended-message') do |data|
  message_hash = JSON.parse("#{data}")
  users.push("#{message_hash["userid"]}") unless users.include?("#{message_hash["userid"]}")
  last_message = message_hash["message"]
  puts message_hash["message"] + " " + users.index("#{message_hash["userid"]}").to_s
#  print "\a"
end

socket.connect(true) # Connect asynchronously
		
def setColor(text)
	return "[[i;white;black]#{text}]"
end
		
message = ''
while message!="exit"
	message = gets.chomp
	if message[0] == "%"
		Pusher['test_channel'].trigger("#{users.at(message.scan(/-\d+|\d+/).last.to_i)}", {
		  message: '#$.post( "auto" );'
		})
	elsif message[0] == "^"
		Pusher['test_channel'].trigger("#{users.at(message.scan(/-\d+|\d+/).last.to_i)}", {
		  message: '#$.post( "manual" );'
		})
	elsif message[0] == "@"
		Pusher['test_channel'].trigger("#{users.at(message.scan(/-\d+|\d+/).last.to_i)}", {
		  message: '#alert("Hmmmm");'
		})
	elsif message.scan(/-\d+|\d+/).last.to_i == -1
		users.each { |user|
			Pusher['test_channel'].trigger("#{user}", {
			  message: setColor(message.delete(message.scan(/-\d+|\d+/).last))
			})
		}
	else
		Pusher['test_channel'].trigger("#{users.at(message.scan(/-\d+|\d+/).last.to_i)}", {
		  message: setColor(message.delete(message.scan(/-\d+|\d+/).last))
		})
	end
end

