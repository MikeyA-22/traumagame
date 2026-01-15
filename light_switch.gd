@tool
extends Interactable

class_name  light_switch



@export var connected_light: Array[Light3D]
@export var light_value: float
@export var on:bool
@export var starter_value: float
func _ready() -> void:
	interactable_actions = {"light_action_pressed":"switch_pressed"}
	SigBus.connect("SWITCH", switch_light)
	for light in connected_light:
		light.light_energy = starter_value

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		for light in connected_light:
			if on and light:
				light.light_energy = light_value
			else:
				light.light_energy = 0


func get_interaction_data(player) -> Dictionary:
	return {
		"interactable": true,
		"sig": SigBus.SWITCH,
		"sig_value": true,
		"reticle": 1
	}



func switch_light(turn_on:bool):
	on = !on
	for light in connected_light:
			if on ==  true:
				light.light_energy = light_value
			else:
				light.light_energy = 0
	#print(on)
	
