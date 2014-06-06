require 'hunspell-ffi'
require 'singleton'

class Dictionary
  include Singleton

    def initialize()
        @dict = Hunspell.new("./app/pl_PL.aff", "./app/pl_PL.dic")
    end

    def checkWords(query)
        checkvalue = true
        checklist = query.delete('^aąbcćdeęfghijklłmnńoóprsśtuwyzźżAĄBCĆDEĘFGHIJKLŁMNŃOÓPRSŚTUWYZŹŻ').split
        checklist.each do |word| 
            if @dict.check(word) == false
                checkvalue = false
                suggestions = @dict.suggest(word)
                if (suggestions.size)
                    return "Chyba coś źle napisałeś, nie chodziło ci przypadkiem o słowo #{suggestions.first} albo #{suggestions.second} :p"
                end
            end
        end
        if !checkvalue
            return "Coś jest nie tak, ale nie wiem o co Ci chodziło :p"
        else
            return checkvalue
        end
    end

    def addWord()
        dict.add("Pieseł")
    end

    def removeWord()
        dict.remove("Koteł")
    end
end

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