extends Action

var target
@export var animation : String
@export var speed : int = 3

@export var fstep_player : AudioStreamPlayer3D

##ACTION TEMPLATE
##MAYBE MAKE THE ACTOR A CHARACTER3D, or 2D. IDK BRUH...
func tick(actor: Enemy, delta, blackboard: Dictionary):
	actor.animation_player.play(animation)
	target = actor.player
	if target == null:
		return STATUS.FAIL
	actor.go_to_target(target, speed)
	fstep_player.play()
	var dist = actor.global_position.distance_to(target.global_position)
	if dist <= actor.attack_radius:  # reached attack range, hand off
		fstep_player.stop()
		return STATUS.SUCCESS
	return STATUS.RUNNING
