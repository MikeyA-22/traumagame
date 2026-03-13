extends MyState
class_name MIdle


func check_transition(input: InputPackage) -> String:
	if input.actions[0] == "walk":
		return "walk"
	elif input.actions[0] == "hidden":
		return "hidden"
	return "okay"
	
	
func on_enter():
	body.velocity = Vector3.ZERO
