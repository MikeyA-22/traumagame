extends MyState


func on_enter():
	SigBus.OFF_FLASH.emit()

func check_transition(input: InputPackage) -> String:
	if !Game_Global.hidden:
		return "idle"
	return "okay"
