extends MyState
class_name UsePills

const transition_timing = 3.3333

func on_enter():
	pass


func check_transition(input: InputPackage) -> String:
	if works_longer_than(transition_timing):
		return input.interactions[0]
	return "okay"
