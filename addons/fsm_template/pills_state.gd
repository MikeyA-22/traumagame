extends State
class_name PillsState
#Step 1: redefine your class_name

const transition_timing = 0.3
var pills_amount = 5
# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "pick"
	move_name = "pick"

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
	if pills_amount > 0:
		SigBus.PILLS.emit()
		print(Game_Global.madness_increment)
		
		if Game_Global.madness_increment > 0:
			Game_Global.madness_increment = 0
			RenderingServer.global_shader_parameter_set("heat_strength", Game_Global.madness_increment)
		pills_amount -= 1
		print(pills_amount)
