require 'pusher'
require 'pusher-client'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"
APP_KEY = '0b6500a2c511ef6a91ba'

def checkExtra(question)
  if question == "robię kluski"
      Pusher['test_channel'].trigger("#{session[:session_id]}", {
        message: '#setTimeout(function() { alert("Kluski gotowe"); }, 10);'
      })
     return "Przypomne Ci o tym za 10 min :p"
	elsif question =~ /godzin/
		t = Time.now
    t.utc
    t = t + 2*3600
    t = t.strftime("%I:%M")
		"Jest godzina #{t} :p"
  elsif question =~ /dat/
    t = Time.now
    t.utc
    t = t + 2*3600
    t = t.strftime("%d/%m/%Y")
    "Dzisiaj jest #{t} :p"
  elsif (question =~ /ile/)
    q = question.delete('^+\-\*\/01234567890')
    return "#{eval(q).to_s} :p"
  else
    return true
  end
end