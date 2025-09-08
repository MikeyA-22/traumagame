#VISUALS - OUTPUTTER
extends Node3D
class_name PlayerVisuals

@onready var cube_022 = $Cube_022
@onready var cube_023 = $Cube_023
@onready var cube_024 = $Cube_024
@onready var cube_025 = $Cube_025
@onready var cube_031 = $Cube_031
@onready var cube_035 = $Cube_035


func accept_skeleton(skeleton: Skeleton3D):
	cube_022.skeleton = skeleton.get_path()
	cube_023.skeleton = skeleton.get_path()
	cube_024.skeleton = skeleton.get_path()
	cube_025.skeleton = skeleton.get_path()
	cube_031.skeleton = skeleton.get_path()
	cube_035.skeleton = skeleton.get_path()
	
