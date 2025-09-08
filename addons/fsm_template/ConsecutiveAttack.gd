extends Combo

@onready var hit_1 =$".." as Hit1

const PANIC_CLICK_PREVENTION = 0.1


func _ready() -> void:
	triggered_move = "Hit2"


func is_triggered(input: InputPackage):
	if input.actions.has("Hit1") and hit_1.works_longer_than(PANIC_CLICK_PREVENTION):
		return true
	return false
