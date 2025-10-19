extends AIstate
class_name Stunned

@onready var stun_timer = $"../../StunTimer"
var can_move

func check_transition(delta) -> Array:
	if can_move == true:
		return [true,"idle"]
	return [false,""]

func _on_stun_timer_timeout() -> void:
	can_move = true
	print("back to threatening!")

func on_enter():
	stun_timer.start()
	can_move = false
	
func on_exit():
	stun_timer.stop()
