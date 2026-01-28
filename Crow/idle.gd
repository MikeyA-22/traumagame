extends Action


@export var animation : String
func tick(actor, delta, blackboard: Dictionary):
	actor.anim_player1.play(animation)
	print("IDLING???")
	return STATUS.RUNNING
