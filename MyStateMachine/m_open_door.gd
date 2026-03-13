extends MyState

const transition_timing = 0.001

func on_enter():
	if Game_Global.current_interactor != null and Game_Global.current_interactor.is_in_group("Doors"):
		#print("happens")
		SigBus.DOOR.emit(true)
		

func check_transition(input: InputPackage) -> String:
	if works_longer_than(transition_timing):
		return "idle"
	return "okay"
