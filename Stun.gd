extends AIstate

class_name Stun

@export var radius:float = 0.2
var angle:float = 0.0
@export var speed:float = 2
@export var y_pos = 0
@onready var noose_pin:StaticBody3D = $"../../StaticBody3D"


func check_transition(delta)->Array:
	if monster.global_position.distance_to(spawn_point) < character.aggro_radius and player.global_position.distance_to(character.position) < character.deaggro_radius:
		return[true,"idle"]
	return[false,""]
	
func update(delta):
	circular_motion()
	
func circular_motion():
	angle += monster.rotation.y - character.rotation.y
	
	var x_pos = cos(angle)
	var z_pos = sin(angle)
	
	character.position.x = (radius * x_pos) + noose_pin.position.x
	character.position.y = 0
	character.position.z = (radius * z_pos) + noose_pin.position.z
