extends AIstate

class_name Canstun

@export var radius:float = 0.2
var angle:float = 0.0
@export var speed:float = 2
@export var y_pos:float = 0
@onready var root:Node3D = $"../.."
var monster_inrange : bool = true
var hittable = false

func on_enter():
	monster_inrange = true

func check_transition(delta)->Array:
	if Game_Global.hidden:
		return[true,"idle"]
	elif monster_inrange == false:
		return[true, "idle"]
	elif hittable == true and Input.is_action_just_pressed("twogbosa"):
		return[true,"stun"]
	return[false,""]
	
func update(delta):
	#circular_motion()
	RenderingServer.global_shader_parameter_set("heat_strength", Game_Global.madness_increment)
	Game_Global.madness_increment += .00005 * delta

	#print(Game_Global.madness_increment)
	
func circular_motion():
	angle += monster.rotation.y - character.rotation.y
	
	var x_pos = cos(angle)
	var z_pos = sin(angle)
	
	character.position.x = (radius * x_pos) + root.position.x
	character.position.y = 0
	character.position.z = (radius * z_pos) + root.position.z


func _on_effect_area_body_exited(body: Node3D) -> void:
	if body == monster:
		monster_inrange = false


func _on_hitbox_body_entered(body: Node3D) -> void:
	if body == monster:
		hittable = true
		
		#SigBus.STUNNED.emit()
