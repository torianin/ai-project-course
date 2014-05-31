require 'pusher'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

Pusher['test_channel'].trigger('my_event', {
  message: 'hello world\r\n'
})
