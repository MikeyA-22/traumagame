extends MyState
class_name Walk

const SPEED = 5.0
@export var ACCELERATION:float = 0.1
@export var DECELERATION:float = 0.25

@export var dampener : float

func on_enter():
	audio_player.stream_paused = false
	audio_player.play() 
	

func check_transition(input: InputPackage) -> String:
	if body.velocity.length() < 0.1:
		return "idle"
	if input.input_direction.length() > 0.01:
		return "okay"
	if input.input_direction.length() <= 0.01 and body.velocity.length() >= 0.1:
		return "okay"
	return input.actions[0]

func on_exit_state():
	audio_player.stop()
	
func update(input: InputPackage, delta: float):
	body.velocity = velocity_by_input(input, delta)
	#player.look_at(player.camera_mount.global_position - player.velocity)
	body.move_and_slide()
	

func velocity_by_input(input : InputPackage, delta: float) ->  Vector3:
	
	var new_velocity = body.velocity
	
	var direction = (body.camera_mount.basis * Vector3(-input.input_direction.x, 0, -input.input_direction.y)).normalized()
	if direction:
		new_velocity.x = lerp(body.velocity.x,direction.x * SPEED,ACCELERATION)
		new_velocity.z = lerp(body.velocity.z,direction.z * SPEED,ACCELERATION)
	else:
		new_velocity.x = lerp(body.velocity.x, 0.0, DECELERATION)
		new_velocity.z = lerp(body.velocity.z, 0.0, DECELERATION)

	if not body.is_on_floor():
		new_velocity.y -= gravity * delta * dampener
	
	return new_velocity
