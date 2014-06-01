require './app/utilities'
require 'programr'

class Alice
	def createAlice
		@robot = ProgramR::Facade.new
		@robot.learn(['./aiml/test.aiml','./aiml/seks.aiml','./aiml/profil_clienta.aiml','./aiml/przywitania.aiml'])
	end

	def askAlice(question)
		question = removeSpacialChars(question)
		spellcheck = question.split(/[^\w-]+/)
		spellcheck.each { |r| if !$pociete.include?(r) return "Chyba coś źle napisałeś :p" }	
		reaction = @robot.get_reaction(question)
	end
end

$alice = Alice.new()
$alice.createAlice