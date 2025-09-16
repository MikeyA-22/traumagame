
extends CharacterBody3D


@onready var inputgatherer = $InputGatherer
@onready var Model = $Model
@onready var camera_mount =$visuals/Cube_022/LocalCamera
@onready var visuals = $visuals as PlayerVisuals
@onready var light = $"visuals/Cube_022/LocalCamera/Camera3D/Flashlight Receiver" as FlashlightReceptor

func _ready() -> void:
	
	visuals.accept_skeleton(Model.skeleton)
	#Model.anim_tree.set("parameters/conditions/idle", true)
	#Model.animator.play("idle")

func _physics_process(delta: float) -> void:
	var input = inputgatherer.gather_input()
	
	Model.update(input, delta)
	
	
	input.queue_free()
	#Visuals -> follow parent transformation
	
