# encoding: utf-8

require './app/utilities'
require 'ferret'  
require 'singleton'
load './tori/seks.tori'

def clear()
  `rm -R ./index/*`
end

class Robert
  include Singleton
  include Ferret  

  def initialize()
    @index = Index::Index.new(:path => './index')  
  end

  def addQuestions()
    $seks_questions.each { |question| 
      @index << question
    }
    puts @index.size
  end

  def askRobert(question)
    @index.search_each("q:#{question}") do | id, score |  
      if @index[id][:a]!=nil
        return "#{@index[id][:a]}" 
      # else
      #   regexp_value =  /#{@index[id][:q1]}/.match(q)[1]
      #   a = @index[id][:r].gsub(/[*]/, regexp_value)
      #   return "#{a}" 
      end
    end
    return_messages = Array.new()
    return_messages[0] = "Chyba coś źle napisałeś, nie chodziło ci przypadkiem o słowo #{@correction} :p"
    return_messages[1] = "Wydaje mi się, że miałeś na myśli słowo #{@correction} :p"
    return_messages[2] = "A nie powinno być #{@correction} zamiast #{word} :p"
    return return_messages[Random.rand(3)]
  end
end

clear
r = Robert.instance
r.addQuestions

# index.search_each('p:#{p} AND q:nie') do | id, score |  
#     puts "SCORE: #{score}\tTITLE: #{index[id][:a]}"  
# end
=begin
q = "lolem jestes"
index.search_each('q1|q2|q3|q4:kocham cie') do | id, score |  
    if index[id][:a]!=nil
    	puts "SCORE: #{score}\tTITLE: #{index[id][:a]}" 
    else
    	regexp_value =  /#{index[id][:q1]}/.match(q)[1]
    	a = index[id][:r].gsub(/[*]/, regexp_value)
    	puts "SCORE: #{score}\tTITLE: #{a}" 
    end
end
=end