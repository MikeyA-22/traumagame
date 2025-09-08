extends State
class_name Idle



func _ready() -> void:
	animation = "idle"

func check_request(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "midair"
	input.actions.sort_custom(priority_sort)
	return input.actions[0]
	

func on_enter_state():
	player.velocity = Vector3.ZERO
