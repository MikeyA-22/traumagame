extends Interactable

class_name HidingSpot
var hidden =  false
@onready var hidden_cam: Camera3D = $Camera3D
var mouse_is_captured = true
@export var hide_location: Vector3
func _ready() -> void:
	interactable_actions = {"light_action_pressed":"hide"}
	SigBus.connect("HIDE", hide)
	if hidden:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if hidden:
		if event.is_action_released("ui_cancel"):
			switch_mouse()
		if event is InputEventMouseMotion and mouse_is_captured:
			var d_hor = event.relative.x
			hidden_cam.rotate_y(- d_hor / 1000)
			#player.rotate_y(- d_hor/1000)
			#var d_ver = event.relative.y
			#clamp(d_ver,0,10)
			#hidden_cam.rotate_x(d_ver/1000)


func switch_mouse():
	if mouse_is_captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_is_captured = !mouse_is_captured

func hide(isHiding, player):
	if hidden == false:
		hidden_cam.make_current()
		player.position = hide_location
	else:
		player.camera_mount.player_camera.make_current()
	hidden = !hidden
	player.hidden = hidden
	player.Model.switch_to("hidden")
	print("hidden: ", hidden)
	print("player hidden: ", player.hidden)
