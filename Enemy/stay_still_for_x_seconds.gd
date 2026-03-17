extends Action


var stunned = true
@export var timer: Timer

##ACTION TEMPLATE
##MAYBE MAKE THE ACTOR A CHARACTER3D, or 2D. IDK BRUH...
func tick(actor: Enemy, delta, blackboard: Dictionary):
	stunned = blackboard.get("stunned")
	#print("time left: ",timer.time_left)
	actor.animation_player.play("stun")
	#print("STUNNED...")
	if stunned == true:
		return STATUS.RUNNING
	elif stunned == false:
		return STATUS.SUCCESS
	


func _on_stun_timer_timeout() -> void:
	#print("CAN MOVE NOW")
	stunned = false
	blackboard.set("stunned", stunned)
	
	
