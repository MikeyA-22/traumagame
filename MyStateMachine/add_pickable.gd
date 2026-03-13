class_name AddPickable
extends MyState

@onready var model = $"../.."
@onready var inventory = $"../../Inventory"
@onready var photobook = $"../../Photobook"

const transition_timing = 0.001

func on_enter():
	if Game_Global.is_pickable == true:
		if Game_Global.current_pickable is Photo:
			photobook.add(Game_Global.current_pickable, true)
			#model.set_active_object(Game_Global.current_pickable)
		else:
			inventory.add(Game_Global.current_pickable, true)
			print("ADDED PICKABLE")
			#debugprintcurrentanimation()

func check_transition(input: InputPackage) -> String:
	if works_longer_than(transition_timing):
		return "idle"
	return "okay"
