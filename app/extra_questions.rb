def checkExtra(question)
	if question =~ /godzin/
		t = DateTime.now
    t = t.in_time_zone(+2)
    t = t.strftime("%I:%M")
		"Jest godzina #{t} :p"
  elsif question =~ /dat/
    t = DateTime.now
    t = t.in_time_zone(+2)
    t = t.strftime("%d/%m/%Y")
    "Dzisiaj jest #{t} :p"
  else
    return true
  end
end
#message = gets.chomp
#puts checkExtra(message)