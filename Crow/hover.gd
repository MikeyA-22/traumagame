extends AIstate

class_name CrowIdle

@export var radius:float = 0.2


@export var speed:float = 2
@export var y_pos:float = 0
@onready var root:Node3D = $"../.."
var angle:float = 0.0
@export var x_min:float = -1
@export var x_max:float = 1
@export var z_min:float = -1
@export var z_max:float = 1
@onready var monster_inrange:bool = false


func on_enter():
	monster_inrange = false

func check_transition(delta) -> Array:
	if monster_inrange == true:
		return[true,"canstun"]
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
	
	character.position.x = (radius * x_pos) + root.position.x
	character.position.y = 0
	character.position.z = (radius * z_pos) + root.position.z
	#print(position.z)
	





func _on_effect_area_body_entered(body: Node3D) -> void:
	if body == monster:
		print(monster_inrange)
		monster_inrange = true
		
