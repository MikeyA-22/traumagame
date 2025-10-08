extends Pickable

class_name Key
##change template

func _ready() -> void:
	messages = ["[color=red]With this key I can open the door, and escape this {p=0.5} [shake rate=10 level=20]HELLL!!!![/shake][/color]"]
	
	##change state mapping
	pickable_action = {
		"light_attack_pressed" : "open_door"
	}
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
##ADD WHATEVER FUNCTIONALITY IS NEEDED
