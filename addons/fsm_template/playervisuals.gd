#VISUALS - OUTPUTTER
extends Node3D
class_name PlayerVisuals

@onready var cube_022 = $Cube_022


func accept_skeleton(skeleton: Skeleton3D):
	cube_022.skeleton = skeleton.get_path()
