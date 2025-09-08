extends RayCast3D

@onready var root = $"../Root"
@onready var targetsphere = $targetsphere


func _process(delta: float) -> void:
	global_position = root.global_position
	targetsphere.global_position = get_collision_point()
