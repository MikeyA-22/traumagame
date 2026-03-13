extends MyState






const transition_timing = 0.001


# Step 3: implement a check_relevance function
func check_transition(input: InputPackage) -> String:
	if works_longer_than(transition_timing):
		return "idle"
	return "okay"



func on_enter():
	SigBus.FLASH.emit()
	if Game_Global.active_tut_index == 2:
		Game_Global.progress_tutorial()
