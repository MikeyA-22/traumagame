extends Interactable
class_name HidingSpot

var hidden = false
@export var hidden_cam: Camera3D
@export var hide_point: Node3D
@export var hide_offset: Vector3
@export var hide_label: Label
@export var player: Player

var mouse_is_captured = true
var can_toggle = true
var toggle_cooldown = 0.3
var toggle_timer = 0.0

func _ready() -> void:
	interactable_actions = {"light_action_pressed":"hidden"}
	SigBus.connect("HIDE", hide)
	hide_label.visible = false
	if hidden:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if not can_toggle:
		toggle_timer -= delta
		if toggle_timer <= 0:
			can_toggle = true

	
	if hidden and can_toggle and Input.is_action_just_pressed("interact"):
		hide(player)

func _input(event: InputEvent) -> void:
	if hidden:
		if event.is_action_released("ui_cancel"):
			switch_mouse()
		
		if event is InputEventMouseMotion and mouse_is_captured:
			var sensitivity := 0.002
			var max_look_up := deg_to_rad(40)
			var max_look_down := deg_to_rad(-40)
			var max_look_side := deg_to_rad(60)


			if not hidden_cam.has_meta("yaw"):
				hidden_cam.set_meta("yaw", 0.0)
				hidden_cam.set_meta("pitch", 0.0)
			var yaw = hidden_cam.get_meta("yaw")
			var pitch = hidden_cam.get_meta("pitch")

			yaw -= event.relative.x * sensitivity
			pitch -= event.relative.y * sensitivity

			pitch = clamp(pitch, max_look_down, max_look_up)
			yaw = clamp(yaw, -max_look_side, max_look_side)

			var base_transform := hide_point.global_transform
			var new_basis := base_transform.basis
			new_basis = Basis(Vector3.UP, yaw) * Basis(Vector3.RIGHT, pitch) * base_transform.basis
			hidden_cam.global_transform.basis = new_basis
			hidden_cam.global_position = hide_point.global_position

			hidden_cam.set_meta("yaw", yaw)
			hidden_cam.set_meta("pitch", pitch)


func get_body_entered(body: Node3D):
	if body is Player:
		hide_label.visible = true

func get_body_exited(body: Node3D):
	if body is Player:
		hide_label.visible = false

func switch_mouse():
	if mouse_is_captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_is_captured = !mouse_is_captured

func hide(player):
	if not can_toggle:
		return  # avoid spamming toggle instantly

	can_toggle = false
	toggle_timer = toggle_cooldown

	hidden = !hidden
	if hidden:
		hidden_cam.make_current()
		player.set_position(hide_point.global_position)
		player.visible = false
		hide_label.visible = false
	else:
		player.camera_mount.player_camera.make_current()
		player.set_position(hide_point.global_position - hide_offset)
		player.visible = true

	Game_Global.hidden = hidden
	print("hidden: ", hidden)
