def checkExtra(question)
	if question =~ /godzin/
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
  else
    return true
  end
end
#message = gets.chomp
#puts checkExtra(message)