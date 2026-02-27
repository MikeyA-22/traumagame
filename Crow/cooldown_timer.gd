class_name CrowCooldownTimer
extends Timer
 

@export var eye_float : float
@onready var crow_mesh_instance = $"../Crow2/rig/GeneralSkeleton/Cube"
var canstun = true
var eye_mat: StandardMaterial3D




func _on_timeout() -> void:
	set_eye_mat(0.75)


func set_eye_mat(eye_mat_float):
	eye_float = eye_mat_float
	eye_mat = crow_mesh_instance.mesh.surface_get_material(2)
	eye_mat.emission_energy_multiplier = eye_float
