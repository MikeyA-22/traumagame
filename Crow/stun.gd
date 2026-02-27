extends AIstate

class_name Stun

@export var radius:float = 0.2
var angle:float = 0.0
@export var speed:float = 2
@export var y_pos:float = 0
## TODO: MAKE ALL STATES INHERIT ROOT FROM THE MACHINE!
@onready var root:Node3D = $"../.."
var monster_inrange : bool = true

@onready var cooldown_timer : CrowCooldownTimer = $"../../CooldownTimer"

@onready var crow_caw_player = $"../../crowplayer"

func on_enter():
	crow_caw_player.play()
	if player.resources.sanity > 0:
		RenderingServer.global_shader_parameter_set("heat_strength", Game_Global.madness_increment)
		Game_Global.madness_increment += .0075
		#print(Game_Global.madness_increment)
		player.resources.sanity -= 10
		#print(player.resources.sanity)
		monster.statemachine.switch_to("stunned")
	monster_inrange = false
	cooldown_timer.start()
	cooldown_timer.set_eye_mat(0)

func check_transition(delta)->Array:
	if monster_inrange == false:
		return[true,"idle"]
	return[false,""]
	
func update(delta):
	pass#circular_motion()
	
func circular_motion():
	angle += monster.rotation.y - character.rotation.y
	
	var x_pos = cos(angle)
	var z_pos = sin(angle)
	
	character.position.x = (radius * x_pos) + root.position.x
	character.position.y = 0
	character.posit
