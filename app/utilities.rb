require 'hunspell-ffi'
require 'singleton'

class Dictionary
  include Singleton

    def initialize()
        @dict = Hunspell.new("./app/pl_PL.aff", "./app/pl_PL.dic")
    end

    def checkWords(query)
        checkvalue = true
        checklist = query.delete('^ aąbcćdeęfghijklłmnńoóprsśtuwyzźżAĄBCĆDEĘFGHIJKLŁMNŃOÓPRSŚTUWYZŹŻ').split
        checklist.each { |word| 
            if @dict.check(word) == false
                checkvalue = false
                suggestions = @dict.suggest(word)
                if (suggestions.size)
                    @correction = suggestions.first
                    return_messages[0] = "Chyba coś źle napisałeś, nie chodziło ci przypadkiem o słowo #{@correction} :p"
                    return_messages[1] = "Wydaje mi się, że miałeś na myśli słowo #{@correction} :p"
                    return_messages[2] = "A nie powinno być #{@correction} zamiast #{word} :p"
                    return return_messages[Random.rand(2)]
                end
            end
        }
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