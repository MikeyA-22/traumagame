extends Interactable

class_name HidingSpot
var hidden =  false
@export var hidden_cam: Camera3D
@export var hide_point:Node3D
var mouse_is_captured = true
@export var hide_offset: Vector3
func _ready() -> void:
	interactable_actions = {"light_action_pressed":"hidden"}
	SigBus.connect("HIDE", hide)
	if hidden:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _process(delta: float) -> void:
	if hidden:
		pass#if Input.is_action_just_pressed("interact"):
			

func _input(event: InputEvent) -> void:
	if hidden:
		if event.is_action_released("ui_cancel"):
			switch_mouse()
		#if event is InputEventMouseMotion and mouse_is_captured:
			#var d_hor = event.relative.x
			#clamp(d_hor,-20,0)
			#hidden_cam.rotate_y(- d_hor / 1000)
			##player.rotate_y(- d_hor/1000)
			#var d_ver = event.relative.y
			
			#hidden_cam.rotate_x(d_ver/1000)


func switch_mouse():
	if mouse_is_captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_is_captured = !mouse_is_captured

func hide(isHiding, player,interaction_catcher:RayCast3D):
	hidden = !hidden
	if hidden == true:
		hidden_cam.make_current()
		player.set_position(hide_point.global_position)
		#player.set_basis(hidden_cam.basis)
		
	else:
		player.camera_mount.player_camera.make_current()
		player.set_position(hide_point.global_position - hide_offset)
		#player.set_basis(Basis(Vector3.ZERO.normalized(),0))
		#player.camera_mount.player_camera.set_basis(Basis(Vector3.ZERO.normalized(),0))
	Game_Global.hidden = hidden
	print("hidden: ", hidden)
	print("player hidden: ", Game_Global.hidden)
