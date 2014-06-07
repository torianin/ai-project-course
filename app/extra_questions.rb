def checkExtra(question)
	if question =~ /godzin/
		t = Time.now
		"Jest godzina #{t.hour} :p"
  elsif question =~ /dat/
    t = Time.now
    t = t.strftime("%m/%d/%Y")
    "Dzisiaj jest #{t} :p"
  else
    return true
  end
end
#message = gets.chomp
#puts checkExtra(message)