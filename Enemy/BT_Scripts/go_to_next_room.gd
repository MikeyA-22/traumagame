extends Action

var target

@export var close_dist : float = 5
@export var speed = 1.5
@export var fstep_player : AudioStreamPlayer3D

##ACTION TEMPLATE
##MAYBE MAKE THE ACTOR A CHARACTER3D, or 2D. IDK BRUH...
func tick(actor: Enemy, delta, blackboard: Dictionary):
	actor.animation_player.play("walk")
	var rooms = blackboard.get("rooms")
	var next_room = rooms[rooms.size() - 1]
	blackboard.set("next_room", next_room)
	target = next_room
	if target == null:
		return STATUS.FAIL
	else:
		var dist : Vector3 = actor.global_position - target.global_position
		actor.go_to_target(target, speed)
		play_sound()
		if dist.length() <= close_dist:
			print("GOT TO ROOM!! AT: ", UID)
			blackboard.set("next_room", null)
			#fstep_player.stop()
			return STATUS.SUCCESS
		else:
			return STATUS.RUNNING
	

func play_sound():
	if fstep_player.playing == false:
			fstep_player.play()
			
			
