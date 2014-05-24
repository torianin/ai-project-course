require 'programr'

def createAlice
	robot = ProgramR::Facade.new
	robot.learn(test.aiml)
end

def askAlice(question)
	reaction = robot.get_reaction(question)
end