extends Camera3D

class_name PlayerCam

var shake_intensity : float = 0.0
var active_shake_time: float = 0.0

var shake_decay : float = 5.0

var shake_time: float = 0.0
var shake_time_speed : float = 20.0

var offset: Vector2

var noise = FastNoiseLite.new()


func _ready() -> void:
	offset = Vector2(h_offset,v_offset)

func _physics_process(delta: float) -> void:
	if active_shake_time > 0:
		
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		print("shaking: ", shake_time," active_shake_time: ", active_shake_time)
		
		h_offset = noise.get_noise_2d(shake_time,0) * shake_intensity
		v_offset = noise.get_noise_2d(0, shake_time) * shake_intensity
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		h_offset = lerp(h_offset,0.0, 10.5 * delta)
		v_offset = lerp(v_offset,0.0,10.5 * delta)

func screen_shake(intensity: int, duration: float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = duration
	shake_time = 0.0
	
