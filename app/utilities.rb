require "rubygems" # import gem package manager
gem "hunspell"     # load Hunspell module
require "Hunspell" # inject Hunspell class to Ruby namespace

# instantiate Hunspell with Hungarian affix and dictionary files
#

sp = Hunspell.new("./app/pl_PL.aff", "./app/pl_PL.dic") 

# spell check Hungarian word 'ablak' (window) => true
#
puts "Is 'ablak' correct? #{sp.spellcheck('ablak')}"

# get suggestions for mispelled word 'paprika'
#   => ["kaprica", "patrica", "paprika", "papcica",
#       "papráca", "papruca", "paprima", "paprikáz",
#       "paprikása", "paprikás", "Papradnó"
#      ]
#
puts "Suggestions for 'paprica': " + sp.suggest("paprica").inspect

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