def removeSpacialChars(text)
    text = text.downcase
    text
    text.gsub!(/[âäàãáäå�?ăąǎǟǡǻ�?ȃȧẵặ]/,'a')
    text.gsub!(/[ëêéèẽēĕėẻȅȇẹȩęḙḛ�?ếễểḕḗệ�?]/,'e')
    text.gsub!(/[�?iìíîĩīĭïỉ�?ịįȉȋḭɨḯ]/,'i')
    text.gsub!(/[òóôõ�?�?ȯö�?őǒ�?�?ơǫ�?ɵøồốỗổȱȫȭ�?�?ṑṓ�?ớỡởợǭộǿ]/,'o')
    text.gsub!(/[ùúûũūŭüủůűǔȕȗưụṳųṷṵṹṻǖǜǘǖǚừứữửự]/,'u')
    text.gsub!(/[ỳýŷỹȳ�?ÿỷẙƴỵ]/,'y')
    text.gsub!(/[ñǹń]/,'n')
    text.gsub!(/[çć]/,'c')
    text.gsub!(/[ß]/,'ss')
    text.gsub!(/[œ]/,'oe')
    text.gsub!(/[ĳ]/,'ij')
    text.gsub!(/[�?ł]/,'l')
    text.gsub!(/[ś]/,'s')
    text.gsub!(/[źż]/,'z')
    text.gsub!(/[^a-zA-Z 0-9]/, "")
    text.gsub!(/\s/,' ')
    text.gsub!(/\-+$/,'')
    text.gsub!(/^\-+/,'')
    text	
end