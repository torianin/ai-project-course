require './app/utilities'
require 'programr'
require 'singleton'

class Alice
	include Singleton

	def initialize()
		@robot = ProgramR::Facade.new
		@robot.learn(['./aiml/test.aiml','./aiml/seks.aiml','./aiml/profil_clienta.aiml','./aiml/przywitania.aiml','./aiml/bot.aiml','./aiml/film.aiml','./aiml/przeklenstwa.aiml'])
	end

	def askAlice(question)
		question = removeSpacialChars(question)
		reaction = @robot.get_reaction(question)
	end
end
