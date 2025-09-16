extends Pickable

###class_name Class_name_here
##change template

func _ready() -> void:
	##change state mapping
	pickable_action = {
		"light_attack_pressed" : "STATE TO MAP TO"
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
##ADD WHATEVER FUNCTIONALITY IS NEEDED
