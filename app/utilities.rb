require 'hunspell-ffi'

# directly specify dictionaries (legacy)
dict = Hunspell.new("./app/pl_PL.aff", "./app/pl_PL.dic")

dict.spell("walked")        # => true  same as #check, #check?
dict.spell("woked")         # => false
dict.check?("woked")        # => false
dict.suggest("woked")       # => ["woke", "worked", "waked", "woken", ...]
dict.suggest("qwss43easd")  # => []

dict.stem("Baumkuchen")     # => ["Baumkuchen"]
dict.analyze("Baumkuchen")  # => [" st:Baumkuchen"]

# Modify the run-time dictionary:
dict.add("Geburtstagskuchen")
dict.remove("Fichte")

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
    text.gsub!(/[^a-zA-Z 0-9]/, "")
    text.gsub!(/\s/,' ')
    text.gsub!(/\-/,' ')
    text
end