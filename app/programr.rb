def askAlice(question)
	if !robot
		robot = ProgramR::Facade.new
		robot.learn(test.aiml)
	end
	reaction = robot.get_reaction(question)
end