extends AIstate

class_name Stun

@export var radius:float = 0.2
var angle:float = 0.0
@export var speed:float = 2
@export var y_pos:float = 0
@onready var noose_pin:StaticBody3D = $"../../StaticBody3D"
var monster_inrange : bool = true


func on_enter():
	if player.resources.sanity > 0:
		RenderingServer.global_shader_parameter_set("static_noise_intensity", Game_Global.noise_int)
		Game_Global.noise_int += .15
		print(Game_Global.noise_int)
		player.resources.sanity -= 10
		print(player.resources.sanity)
		monster.statemachine.switch_to("stunned")
	monster_inrange = false

func check_transition(delta)->Array:
	if monster_inrange == false:
		return[true,"idle"]
	return[false,""]
	
func update(delta):
	
	circular_motion()
	
func circular_motion():
	angle += monster.rotation.y - character.rotation.y
	
	var x_pos = cos(angle)
	var z_pos = sin(angle)
	
	character.position.x = (radius * x_pos) + noose_pin.position.x
	character.position.y = 0
	character.position.z = (radius * z_pos) + noose_pin.position.z
