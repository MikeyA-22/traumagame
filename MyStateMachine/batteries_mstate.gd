extends MyState



@onready var inventory = $"../../Inventory"
var battery_charge: int = 50
const transition_timing = 1.333
var item_data: ItemData = load("res://Resource/Batteries.tres")



func on_enter():
		SigBus.BATTERIES.emit(battery_charge, inventory, item_data)
		print(inventory.items)

func check_transition(input: InputPackage) -> String:
	if works_longer_than(transition_timing):
		return "idle"
	return "okay"
