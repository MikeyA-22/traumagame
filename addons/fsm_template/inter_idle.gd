extends MyState
class_name InterIdle


func check_transition(input: InputPackage) -> String:
	if input.interactions.size() > 0:
		if input.interactions[0] != state_name:
			return input.interactions[input.interactions.size() - 1]
	return "okay"
	
	
