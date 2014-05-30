#!/usr/bin/ruby -w

require 'nokogiri'
require 'open-uri'

def removeSpacialChars(text)
    text
    text.gsub!(/[Ąâàãáäåăąǎǟǡǻȃȧẵặ]/,'a')
    text.gsub!(/[Ęëêéèẽēĕėẻȅȇẹȩęḙḛếễểḕḗệ]/,'e')
    text.gsub!(/[iìíîĩīĭïỉịįȉȋḭɨḯ]/,'i')
    text.gsub!(/[Óòóôõȯöőǒơǫɵøồốỗổȱȫȭṑṓớỡởợǭộǿ]/,'o')
    text.gsub!(/[ùúûũūŭüủůűǔȕȗưụṳųṷṵṹṻǖǜǘǖǚừứữửự]/,'u')
    text.gsub!(/[ỳýŷỹȳÿỷẙƴỵ]/,'y')
    text.gsub!(/[Ńñǹń]/,'n')
    text.gsub!(/[Ćçć]/,'c')
    text.gsub!(/[ß]/,'ss')
    text.gsub!(/[œ]/,'oe')
    text.gsub!(/[ĳ]/,'ij')
    text.gsub!(/[ł]/,'l')
    text.gsub!(/[Śś]/,'s')
    text.gsub!(/[ŻŹźż]/,'z')
    text = text.downcase
    text.gsub!(/[^a-zA-Z ;:()]/, "")
    text.gsub!(/\s/,' ')
    text.gsub!(/\-/,' ')
    text
end


all = 0
words = Hash.new(0)

doc = Nokogiri::HTML(open('messages.htm'))
users = doc.css(".user")
users.each do |i|
	if (i.text == "Robert Ignasiak")
		split_words = removeSpacialChars(i.parent.parent.next.text).split(" ")
		split_words.each do |w|
			words[w.ljust(30)] += 1
			all += 1
		end
	end
end

puts all
out = words.sort { |a,b| b[1]<=>a[1] }
out.each { |key, value| puts "#{key} : #{value} : #{((value.to_f/all.to_f)*100.0).round(4)}%" }