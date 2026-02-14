extends State

class_name BatteriesState

signal batteries


@onready var inventory = $"../Inventory"
var battery_charge: int = 50
const transition_timing = 1.333
var item_data: ItemData = load("res://Resource/Batteries.tres")
#Step 1: redefine your class_name

# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "Batteries"
	move_name = "Batteries"
	#start_marker = "start"
	#end_marker = "stop"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	if works_longer_than(transition_timing):
		input.actions.sort_custom(priority_sort)
		return input.actions[0]
	else:
		return "okay"

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	pass

func on_enter_state():
		SigBus.BATTERIES.emit(battery_charge, inventory, item_data)
		print(inventory.items)
	
