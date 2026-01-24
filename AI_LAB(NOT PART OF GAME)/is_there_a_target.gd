extends Condition


var target

func tick(actor, delta, blackboard: Dictionary):
	target = blackboard.get("target")
	if target == null:
		#print("NO TARGET!")
		return STATUS.FAIL
	else:
		#print("TARGET IS: %s" % target.position)
		return STATUS.SUCCESS
