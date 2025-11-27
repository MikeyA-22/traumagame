extends Node3D

@export var player: Player
@export var my_aberration_x:float
@export var my_aberration_y:float
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("aberration_x",my_aberration_x)
	RenderingServer.global_shader_parameter_set("aberration_y", my_aberration_y)
	#print_debug("x: ", my_aberration_x, "y:", my_aberration_y)
