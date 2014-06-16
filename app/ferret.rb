# encoding: utf-8

require './app/utilities'
require 'ferret'  
require 'singleton'
load './tori/seks.tori'
load './tori/przywitania.tori'
load './tori/przeklenstwa.tori'
load './tori/bot.tori'
load './tori/ja.tori'

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
    $przeklenstwa_questions.each { |question|  
      @index << question
    }
    $bot_questions.each { |question|  
      @index << question
    }
    $przywitania_questions.each { |question|  
      @index << question
    }
    $ja_questions.each { |question|  
      @index << question
    }
    puts @index.size
  end

  def askRobert(question)
    @index.search_each("q:#{question}") do | id, score |  
      if @index[id][:a]!=nil
        return "#{@index[id][:a]}" 
      else
        regexp_value =  /#{@index[id][:q1]}/.match(q)[1]
        a = @index[id][:r].gsub(/[*]/, regexp_value)
        return "#{a}" 
      end
    end
    return_messages = ["Nie kumam :p", "Nie mam pojecia jak Ci odpowiedziec :p", "Możemy zmienić temat :p", "Co robisz jutro o 18 :p"]
    return return_messages[Random.rand(4)]
    #return "Muszę Ci powiedzieć coś bardzo ważnego, ".force_encoding('UTF-8') + @index[Random.rand(75)][:q].downcase.force_encoding('UTF-8') + " :p".force_encoding('UTF-8')
    #return "Bardzo mnie to zastanawia i musze zapytać, ".force_encoding('UTF-8') + @index[Random.rand(75)][:q].downcase.force_encoding('UTF-8') + " :p".force_encoding('UTF-8')
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

#OK <srai> - pozwala definiować synonimy dla pewnych określonych wyrażeń, 
#OK <random> - pozwala wybrać programowi losowy element z listy możliwych; elementy te definiuje się pomiędzy znacznikami <li> i </li>,
#OK <that> - pozwala sprawdzić jedną z poprzednią wypowiedź chatterbota, używane do łączenia odpowiedzi w zależności od ostatniego zdania, // działa
# <think> - używane do przeprowadzenia czynności, które nie mają być wyświetlone dla użytkownika (np. zmiana wartości zmiennej),
# < get/ > i < set > służą do zapisywania i odczytywania zmiennych,
# <condition> - określa określać reakcję w zależności od stanu zmiennej,
# <topic> - pozwala botowi zawęzić pole wyszukiwań szablonów do zadanego działu.