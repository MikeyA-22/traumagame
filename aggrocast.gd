extends RayCast3D
@onready var root = $".."
@onready var target_obj:Enemy = root.player.monster
@export var fixed_ray_length:float = 10

func _physics_process(delta: float) -> void:
	var target_global_pos = target_obj.global_position
	
	var direction_vector = target_global_pos - global_position
	
	target_position = direction_vector.normalized() * fixed_ray_length
