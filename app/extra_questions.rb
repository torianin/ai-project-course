def checkExtra(question)
  if question == "robię kluski"
    return '#setTimeout(function() { alert("Kluski gotowe"); }, 600000);'
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