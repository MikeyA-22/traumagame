extends Condition


func tick(actor, delta, blackboard):
	if Game_Global.hidden == true:
		return STATUS.SUCCESS
	else:
		return STATUS.FAIL
