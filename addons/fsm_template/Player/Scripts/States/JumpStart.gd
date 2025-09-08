extends State
class_name JumpStart
#Step 1: redefine your class_name

const Vertical_Speed_Added : float = 10

const Transition_Timing = 1.0
const Jump_Timing = 0.2

var jumped: bool =  false


# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "jump_start"
	move_name = "jump_start"
	start_marker = "start"
	end_marker = "stop"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	if works_longer_than(Transition_Timing):
		jumped = false
		return "midair"
	else:
		return "okay"

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	if works_longer_than(Jump_Timing):
		if not jumped:
			player.velocity.y += Vertical_Speed_Added
			jumped = true
	player.move_and_slide()

# Step 5: DELETE THE COMMENTS!! DUMMY...
