extends Action


@export var speed: float

func tick(actor, delta, blackboard):
	#print("GOING TO LOCATION")
	var my_pos = blackboard.get("my_pos")
	actor.move_towards(my_pos,speed,delta)
	return STATUS.RUNNING
	
