#VISUALS - OUTPUTTER
extends Node3D
class_name PlayerVisuals

@onready var cube_022 = $body


func accept_skeleton(skeleton: Skeleton3D):
	cube_022.skeleton = skeleton.get_path()
