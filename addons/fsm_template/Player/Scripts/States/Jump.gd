extends State
class_name Jump


const JUMP_VELOCITY = 5
const SPEED = 5.0

func _ready() -> void:
	animation = "jump"
	start_marker = "start"
	end_marker = "stop"
	
func check_request(input : InputPackage):
	if player.is_on_floor():
		input.actions.sort_custom(priority_sort)
		return input.actions[0]
	return "okay"


func update(input: InputPackage, delta : float):
	player.velocity.y -= gravity * delta * dampener
	player.move_and_slide()
	
func on_enter_state():
	player.velocity.y += JUMP_VELOCITY * SPEED

func on_exit_state():
	pass
