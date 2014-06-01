require './app/utilities'
require 'programr'

class Alice
	def createAlice
		@robot = ProgramR::Facade.new
		@robot.learn(['./aiml/test.aiml','./aiml/seks.aiml','./aiml/profil_clienta.aiml','./aiml/przywitania.aiml'])
	end

	def askAlice(question)
		question = removeSpacialChars(question)
		reaction = @robot.get_reaction(question)
	end
end

$alice = Alice.new()
$alice.createAlice