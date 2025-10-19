extends State

class_name Flash

signal flash



const transition_timing = 0.1
#Step 1: redefine your class_name

# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "pick"
	move_name = "pick"
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
	SigBus.FLASH.emit()
