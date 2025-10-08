extends AIstate

class_name CrowIdle

@export var radius:float = 0.2


@export var speed:float = 2
@export var y_pos = 0
@onready var noose_pin:StaticBody3D = $"../../StaticBody3D"
var angle:float = 0.0
@export var x_min:float = -1
@export var x_max:float = 1
@export var z_min:float = -1
@export var z_max:float = 1


func check_transition(delta) -> Array:
	if monster.global_position.distance_to(spawn_point) < character.aggro_radius and monster.global_position.distance_to(character.position) > character.deaggro_radius and Input.is_action_just_pressed("onegbosa"):
		return[true,"stun"]
	return[false,""]
	
func _process(delta: float) -> void:
	circular_motion()
	
func circular_motion():
	#quite literally calculus
	angle += speed * get_process_delta_time()
	
	#var x_pos = cos(angle)
	var x_pos = clamp(cos(angle),x_min,x_max)
	var z_pos = clamp(sin(angle),z_min,z_max)
	
	#var y_pos = tan(angle)
	
	character.position.x = (radius * x_pos) + noose_pin.position.x
	character.position.y = 0
	character.position.z = (radius * z_pos) + noose_pin.position.z
	#print(position.z)
	
