class_name Crow extends Node3D

@export var player: Player
@export var my_aberration_x:float
@export var my_aberration_y:float
@export_group("Camera Shake")
@export var camera: PlayerCam
@export var shake_intensity: int
@export var duration: float
@export var monster : Enemy
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("aberration_x",my_aberration_x)
	RenderingServer.global_shader_parameter_set("aberration_y", my_aberration_y)
	#print_debug("x: ", my_aberration_x, "y:", my_aberration_y)

func camera_shake():
	camera.screen_shake(shake_intensity,duration)
