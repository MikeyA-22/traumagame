extends State
class_name Landing
#Step 1: redefine your class_name

const transition_timing = 0.2

# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "landing"
	start_marker = "start"
	end_marker = "stop"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	if works_longer_than(transition_timing):
		input.actions.sort_custom(priority_sort)
		return input.actions[0]
	else:
		return "okay"

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	player.velocity.y -= gravity * delta * dampener
	player.move_and_slide()
