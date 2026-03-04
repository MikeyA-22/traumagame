extends MyState
class_name InterIdle


func check_transition(input: InputPackage) -> String:
	if input.interactions[0] != state_name:
		return input.interactions[0]
	return "okay"
	
	
