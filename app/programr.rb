require './app/utilities'
require 'programr'

class Alice
	def createAlice
		@robot = ProgramR::Facade.new
		@robot.learn(['./app/test.aiml'])
	end

	def askAlice(question)
		question = removeSpacialChars(question)
		reaction = @robot.get_reaction(question) + " " + question
	end
end

$alice = Alice.new()
$alice.createAlice