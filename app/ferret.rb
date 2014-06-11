require 'ferret'  
require 'singleton'

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

    @index << {  
      :q1 => 'seks',  
      :a => 'Przykro mi nie uprawiam przypadkowego seksu z nieznajomymi :p',  
      :t => 'seks'  
    }   

    @index << {  
      :q1 => 'seks',  
      :a => 'Przykro mi nie uprawiam przypadkowego seksu z nieznajomymi :p',  
      :t => 'seks'  
    }   

    @index << {  
      :q1 => 'boli mnie glowa',  
      :a => 'Dobrze, że mam tabletki na ból głowy :p',  
      :t => 'seks'  
    }   

    @index << {  
      :q1 => 'chce miec z toba dzieci',  
      :a => 'No to bierzmy się do pracy :p',  
      :t => 'seks'  
    }   

    @index << {  
      :q1 => 'jestes (.*)',  
      :r => 'nie jestem *',  
      :t => 'seks'  
    }   

    @index << {  
      :q1 => 'kocham cie', 
      :a => ':*', 
      :t => 'seks'   
    }   

    @index << {  
      :q1 => 'kocham cie', 
      :a => 'pieseł', 
      :t => 'seks'   
    }   

    @index << {  
      :p => 'chcesz ogladać film',
      :q1 => 'tak',  
      :a => 'okej to super',
      :t => 'seks'  
    }   

    @index << {  
      :p => 'chcesz ogladać film',
      :q1 => 'nie',  
      :a => 'no to smutno',
      :t => 'seks'  
    }   

    @index << {  
      :p => 'dobrze ze mam tabletki na ból głowy',
      :q1 => 'nie',  
      :a => 'działa',
      :t => 'seks'  
    }   
  end

  def askRobert(question)
    @index.search_each("q1|q2|q3|q4:#{question}") do | id, score |  
      if @index[id][:a]!=nil
        puts "SCORE: #{score}\tTITLE: #{@index[id][:a]}" 
      else
        regexp_value =  /#{@index[id][:q1]}/.match(q)[1]
        a = @index[id][:r].gsub(/[*]/, regexp_value)
        puts "SCORE: #{score}\tTITLE: #{a}" 
      end
    end
  end
end

#clear
r = Robert.instance
#r.addQuestions
r.askRobert("kocham")
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