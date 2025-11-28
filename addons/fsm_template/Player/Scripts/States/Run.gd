extends State
class_name Run



const SPEED = 5.0
const JUMP_VELOCITY = 5
@export var TURN_SPEED = 1
@export var fstep_player:AudioStreamPlayer3D
@export var ACCELERATION:float = 0.1
@export var DECELERATION:float = 0.25

func _ready() -> void:
	animation = "walk"

func check_request(input: InputPackage) -> String:
	if not player.is_on_floor():
		return "midair"
	
	input.actions.sort_custom(priority_sort)
	
	if player.velocity.length() < 0.1 and player.velocity.length() < 0.1 :
		return "idle"
	if input.input_direction.length() >0.01:
		return "okay"
	if input.input_direction.length() <= 0.01 and player.velocity.length() >= 0.1:
		return "okay"
	return input.actions[0]

func update(input: InputPackage, delta: float):
	player.velocity = velocity_by_input(input, delta)
	#player.look_at(player.camera_mount.global_position - player.velocity)
	player.move_and_slide()
	
func on_enter_state():
	pass

func on_exit_state():
	pass


func velocity_by_input(input : InputPackage, delta: float) ->  Vector3:
	
	var new_velocity = player.velocity
	
	var direction = (player.camera_mount.basis * Vector3(-input.input_direction.x, 0, -input.input_direction.y)).normalized()
	if direction:
		new_velocity.x = lerp(player.velocity.x,direction.x * SPEED,ACCELERATION)
		new_velocity.z = lerp(player.velocity.z,direction.z * SPEED,ACCELERATION)
	else:
		new_velocity.x = lerp(player.velocity.x, 0.0, DECELERATION)
		new_velocity.z = lerp(player.velocity.z, 0.0, DECELERATION)

	if not player.is_on_floor():
		new_velocity.y -= gravity * delta * dampener
	
	return new_velocity
