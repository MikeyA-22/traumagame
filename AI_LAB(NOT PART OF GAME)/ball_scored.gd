extends Condition

@export var scorer_name: String

func tick(actor, delta, blackboard: Dictionary):
	
	var response = blackboard.get("ball_scored")
	var scorer = blackboard.get("scorer_name")
	if response == true && scorer == scorer_name:
		return STATUS.SUCCESS
	else:
		return STATUS.FAIL
