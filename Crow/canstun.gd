extends AIstate

class_name Canstun




@onready var root:Node3D = $"../.."


var angle:float = 0.0
var monster_inrange : bool = true
var hittable = false
var canstun = true

func on_enter():
	monster_inrange = true
	
	

func check_transition(delta)->Array:
	if Game_Global.hidden:
		return[true,"idle"]
	elif monster_inrange == false:
		return[true, "idle"]
	elif hittable == true and Input.is_action_just_pressed("twogbosa") and canstun == true:
		canstun = false
		
		print("GOING TO STUN!!")
		return[true,"stun"]
	return[false,""]
	
func on_exit():
	pass
	
func update(delta):
	#circular_motion()
	RenderingServer.global_shader_parameter_set("heat_strength", Game_Global.madness_increment)
	Game_Global.madness_increment += .00005 * delta

	#print(Game_Global.madness_increment)
	



func _on_effect_area_body_exited(body: Node3D) -> void:
	if body == monster:
		monster_inrange = false


func _on_hitbox_body_entered(body: Node3D) -> void:
	if body == monster:
		hittable = true
		
		#SigBus.STUNNED.emit()


func _on_effect_area_body_entered(body: Node3D) -> void:
	pass # Replace with function body.


func _on_cooldown_timer_timeout() -> void:
	print("I CAN GO AGAIN!")
	canstun = true


	
	
