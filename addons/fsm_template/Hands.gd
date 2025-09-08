extends Weapon

class_name Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	basic_attacks = {
		"light_attack_pressed" : "Hit1"
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
