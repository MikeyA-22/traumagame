extends Node3D

@onready var player = $"../../.."
@onready var player_camera = $Camera3D
var mouse_is_captured = true
@onready var anim_player : AnimationPlayer = $Camera3D/AnimationPlayer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	top_level = true


func _process(delta):
	global_position = player.global_position


func _input(event):
	if event.is_action_released("ui_cancel"):
		switch_mouse()
	
	if Input.get_vector("ui_up","ui_down","ui_right","ui_left"):
		anim_player.play("head_bob")
	
	if event is InputEventMouseMotion and mouse_is_captured:
		var d_hor = event.relative.x
		rotate_y(- d_hor / 1000)
		var d_ver = event.relative.y
		player_camera.rotate_x(d_ver/1000)


func switch_mouse():
	if mouse_is_captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_is_captured = not mouse_is_captured
