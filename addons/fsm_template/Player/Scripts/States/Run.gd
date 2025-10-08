extends State
class_name Run



const SPEED = 5.0
const JUMP_VELOCITY = 5
@export var TURN_SPEED = 1

func _ready() -> void:
	animation = "walk"

func check_request(input: InputPackage) -> String:
	if not player.is_on_floor():
		return "midair"
	
	input.actions.sort_custom(priority_sort)
	if input.actions[0] == "walk":
		return "okay"
	return input.actions[0]

func update(input: InputPackage, delta: float):
	player.velocity = velocity_by_input(input, delta)
	#player.look_at(player.camera_mount.global_position - player.velocity)
	player.move_and_slide()
	
	


func on_exit_state():
	pass


func velocity_by_input(input : InputPackage, delta: float) ->  Vector3:
	var new_velocity = player.velocity
	
	var direction = (player.camera_mount.basis * Vector3(-input.input_direction.x, 0, -input.input_direction.y)).normalized()
	new_velocity.x = direction.x * SPEED
	new_velocity.z = direction.z * SPEED
	
	if not player.is_on_floor():
		new_velocity.y -= gravity * delta * dampener
	
	return new_velocity
