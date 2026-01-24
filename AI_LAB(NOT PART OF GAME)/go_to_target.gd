extends Action

@export var target_name: String = "target"

func tick(actor: LabEnemy, delta, blackboard: Dictionary):
	var target = blackboard.get(target_name)
	actor.move_towards(target)
	#print("GOING TO", target.position)
	#print("my position: %s" % actor.position)
	return STATUS.SUCCESS
	
