require 'pusher-client'
require 'pusher'
require 'json'
require 'shoes'
require 'singleton'
require 'thread'

threads = []

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

APP_KEY = '0b6500a2c511ef6a91ba'

PusherClient.logger = Logger.new(STDOUT)
PusherClient.logger.level = Logger::WARN

last_message = ""

$users = Hash.new

queue = Queue.new

def setColor(text)
  return "[[i;white;black]#{text}]"
end

Shoes.app  :title => "ALL" do
  @macosx = Array.new
  @windows = Array.new

  @socket = PusherClient::Socket.new(APP_KEY)
  @socket.subscribe('sended-message')
  
  @socket['sended-message'].bind('sended-message') do |data|
    message_hash = JSON.parse("#{data}")
    $users["#{message_hash["userid"]}"] = Array.new if $users["#{message_hash["userid"]}"] == nil
    $users["#{message_hash["userid"]}"].push("#{message_hash["message"]}")
    queue << message_hash
  end

  @socket.connect(true) 

  stack do
    @log = para ""
    message = edit_line
    button "Send" do
      $users.each { |user|
        Pusher['test_channel'].trigger("#{user}", {
          message: setColor(message)
        })
      }
    end
  end
  every 1 do
    @log.text = ""
    $users.each { |key, value| 
      @log.text = @log.text + key.to_s
      if !@macosx.include?("#{key.to_s}")
        @macosx.push("#{key.to_s}")
        @windows.push(window :title => "#{key.to_s}")
      end
      if !queue.empty?
        @windows.each { |word|  
         value = Hash.try_convert(queue.pop)
         word.para value["message"] + "\n"
        }  
      end
    }
  end
end