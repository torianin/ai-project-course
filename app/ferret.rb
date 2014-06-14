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
    @index << $seks_questions
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
  end
end

#clear
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