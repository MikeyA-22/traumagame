extends RayCast3D

@onready var root = $"../Root"
@onready var targetsphere = $targetsphere
@onready var fstep_player = $"../Fstep Player"

@export var sound_mapping : Dictionary = {
	"Carpet" : preload("res://Music/footstep/carpet_1.MP3")
}

func _process(delta: float) -> void:
	global_position = root.global_position
	targetsphere.global_position = get_collision_point()
