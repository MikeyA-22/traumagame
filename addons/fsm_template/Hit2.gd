extends State
class_name Hit2

const COMBO_TIMING = 0.97
const TRANSITION_TIMING = 1.1333



func _ready() -> void:
	animation = "hit_2"
	move_name = "hit_2"
	start_marker = "start"
	end_marker = "stop"

func check_request(input: InputPackage):
	checkcombos(input)
	if works_longer_than(COMBO_TIMING) and has_queued_move:
		has_queued_move = false
		return queued_move
	elif works_longer_than(TRANSITION_TIMING):
		input.actions.sort_custom(priority_sort)
		return input.actions[0]
	else: 
		return "okay"

func on_enter_state():
	player.velocity = Vector3.ZERO


func update(input: InputPackage, delta: float):
	pass
