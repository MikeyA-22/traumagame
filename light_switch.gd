@tool
extends Interactable

class_name  light_switch



@export var connected_light: Array[Light3D]
@export var emission_obj: Array[MeshInstance3D]
@export var light_value: float
@export var on:bool
@export var starter_value: float
@export var light_color: Color

func _ready() -> void:
	interactable_actions = {"light_action_pressed":"switch_pressed"}
	SigBus.connect("SWITCH", switch_light)
	for light in connected_light:
		light.light_energy = starter_value
		light.light_color = light_color
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		for light in connected_light:
			if on and light:
				light.light_energy = light_value
				light.light_color = light_color
				
			else:
				light.light_energy = 0
		for obj in emission_obj:
			var mat = obj.mesh.surface_get_material(0)
			if on and obj:
				mat.emission_enabled = true
			else:
				mat.emission_enabled = false
				
			


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
	for obj in emission_obj:
		if obj:
			var mat = obj.mesh.surface_get_material(0)
			if on == true:
				mat.emission_enabled = true
				print(mat.emission_enabled)
			else:
				mat.emission_enabled = false
				print("mat emission: ", mat.emission_enabled)
	#print(on)
	
